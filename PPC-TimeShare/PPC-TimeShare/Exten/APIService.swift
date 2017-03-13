//
//  APIService.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class APIService: NSObject {
    
    static let sharedInstance = APIService()
    let serverErrorMes = LanguageManager.sharedInstance.localizedString(string: "ServerErrorMes")
    
    func fetchResortAll(pageUrl: String, completion : @escaping ([Resort]?, _ errorMessage : String?, _ nextPageUrl: String?)->()){
        let urlString = pageUrl
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let nextPage = response?["next_page_url"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil,nextPage as? String)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes, nil)
                }
                else {
                    completion(nil, errorMes, nil)
                }
                
            }
            
        }
    }
    
    func fetchResortNew(completion : @escaping ([Resort]?, _ errorMessage : String?)->()){
        let urlString = "\(self.getCurrentDomain())resort/new"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
            
        }
    }
    
    func fetchResortRandom(userId: NSNumber?, lat: String?, lng :String?, completion : @escaping ([Resort]?, _ errorMessage : String?)->()){
        
        let useridString = "\(userId)"
        
        let urlString = "\(self.getCurrentDomain())resort/random?lat=\(lat!)&lng=\(lng!)&user_id=\(useridString)"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
            
        }
    }
    func fetchResortNearBy(lat: String, lng : String, completion:@escaping (([Resort]?, String?)->())){
        let urlString = "\(getCurrentDomain())resort/nearby?lat=\(lat)&lng=\(lng)&km=1000"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
            
        }
        
    }
    
    
    func getRecruitments(completion : @escaping ([Recruitment]?, String?)->()){
        let urlString = "\(self.getCurrentDomain())recruitment"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let recruitmentsDic = response?["data"]
                let recruitments = self.getRecruitmentsFrom(dictionary: recruitmentsDic as Any)
                completion(recruitments, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
    }
    
    func requestSignUp(user : User, completion : @escaping (User?, String?)->()){
        
        let urlString = "\(self.getCurrentDomain())register"
        let params = ["email":user.email!,
                      "diachi":user.address!,
                      "hoten":user.userName!,
                      "dienthoai":user.mobileNumber!,
                      "password":user.password!,
                      "avatar": user.avartarUrl!,
                      "sex": user.gender?.genderId as Any] as Dictionary<String,Any>
        
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let userDic = response?["data"]
                let user = User(data: userDic as! Dictionary<String, Any>)
                completion(user, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
    }
    
    func requestSignIn(email: String, passWord : String, completion: @escaping (User?, String?) ->()){
        let urlString = "\(self.getCurrentDomain())login"
        let params = ["email":email, "password": passWord] as Dictionary<String, Any>
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                //parse data
                let userDic = response?["data"]
                let user = User(data: userDic as! Dictionary<String, Any>)
                completion(user, nil)
            }else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }else{
                    completion(nil, errorMes)
                }
            }
        }
    }
    
    func requestGetListVoucher(userId : Int, completion : @escaping ([Voucher]?, String?)->()){
        let urlString = "\(self.getCurrentDomain())vouchers?id=\(userId)"
        getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let voucherDic = response?["data"]
                let vouchers = self.getVouchersFrom(dictionary: voucherDic as Any)
                completion(vouchers, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
    }
    
    func requestUpdate(user : User, completion :@escaping (User?, String?) ->()){
        let urlString = "\(self.getCurrentDomain())profile"
        let params = ["id": user.userId!,
                      "diachi":user.address!,
                      "hoten":user.userName!,
                      "dienthoai":user.mobileNumber!,
                      "avatar": user.avartarUrl!,
                      "sex": user.gender?.genderId as Any,
                      "token":user.token!] as Dictionary<String,Any>
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                let userDic = response?["data"]
                let user = User(data: userDic as! Dictionary<String, Any>)
                completion(user, nil)
            }else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else{
                    completion(nil, errorMes)
                }
            }
        }
        
    }
    
    
    func checkEmail(email : String, completion : @escaping (String?) ->()){
        let urlString = "\(self.getCurrentDomain())check-email"
        let params = ["email": email] as Dictionary<String, Any>
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                completion(nil)
            }else{
                if error != nil{
                    completion(self.serverErrorMes)
                }
                else{
                    completion(errorMes)
                }
            }
        }
    }
    
    func requestGetOffers(completion : @escaping ([Offer]?, String?) ->()){
        let urlString = "\(self.getCurrentDomain())deal"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let offersDic = response?["data"]
                let offers = self.getOffersFrom(dictionary: offersDic as Any)
                completion(offers, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
    }
    func requestBook(user : User, info : BookInfo, voucherId : Int?, completion : @escaping (String?, String?) ->()){
        
        let urlString = "\(self.getCurrentDomain())booking"
        let params = ["id_user": user.userId!,
                      "id_resort":(info.resort?.resortId)! as Any,
                      "note":info.note!,
                      "start_date":info.checkInDate!,
                      "end_date": info.checkOutDate!,
                      "adults": info.numberAdults,
                      "childs":info.numberChilds,
                      "room":info.room!,
                      "token":user.token!,
                      "voucher_id":voucherId ?? ""] as Dictionary<String,Any>
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                
                completion("Success", nil)
            }else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else{
                    completion(nil, errorMes)
                }
            }
        }
    }
    
    func requestGetListBook(userId : NSNumber, completion : @escaping ([BookInfo]?, String?) ->()){
        let urlString = "\(self.getCurrentDomain())bookings?id=\(userId)"
        getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let bookDic = response?["data"]
                let bookings = self.getBooksFrom(dictionary: bookDic as Any)
                completion(bookings, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
        
    }
    func requestGetCountries(completion: @escaping ([Country]?, String?) -> ()){
        let urlString = "\(self.getCurrentDomain())countries"
        
        getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let countriesDic = response?["data"]
                let countries = self.getCountriesFrom(dictionary: countriesDic as Any)
                completion(countries, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
            }
        }
    }
    
    func requestGetProvinces(country: Country, completion: @escaping ([Province]?, String?) -> ()){
        let urlString = "\(self.getCurrentDomain())provinces?country_id=\(country.countryId!)"
        
        getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let provincesDic = response?["data"]
                let provinces = self.getProvincesFrom(dictionary: provincesDic as Any)
                completion(provinces, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
            }
        }
    }
    
    func requestGetTypesResort(completion: @escaping ([TypeResort]?, String?) -> ()){
        let urlString = "\(self.getCurrentDomain())types"
        
        getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let typesDic = response?["data"]
                let types = self.getTypesResort(dictionary: typesDic as Any)
                completion(types, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errorMes)
                }
            }
        }
    }
    
    func requestFilterResort(option : FilterOption, completion:@escaping ([Resort]?, String?, String?) -> ()){
        let countryId = option.country?.countryId
        let cityId = option.province?.provinceId
        let type = option.type?.typeId
        let searchBy = option.searchBy?.searchById
        let urlString = "\(getCurrentDomain())resort/all?country_id=\(countryId!)&city_id=\(cityId!)&type_id=\(type!)&search_by=\(searchBy!)"
        
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let nextPage = response?["next_page_url"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil,nextPage as? String)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes, nil)
                }
                else {
                    completion(nil, errorMes, nil)
                }
                
            }
            
        }
    }
    func requestSearch(keyword: String, completion : @escaping ([Resort]?, String?)->()){
        
        
        var urlString = "\(self.getCurrentDomain())resort/search?q=\(keyword)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                if error == nil && errorMes == nil {
                    let resortsDic = response?["data"]
                    let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                    completion(resorts, nil)
                }
                else{
                    if error != nil{
                        completion(nil, self.serverErrorMes)
                    }
                    else {
                        completion(nil, errorMes)
                    }
                }
            }
        }
    }
    func requestForgotPass(email : String, completion : @escaping ((Bool) ->())) {
        let urlString = "\(self.getCurrentDomain())forget-pass"
        let params = ["email": email] as Dictionary<String,Any>
        
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    
    func requestSendRequest(email : String, name : String, mobile : String, title : String, content : String, completion:@escaping ((Bool)->())){
        
        let urlString = "\(self.getCurrentDomain())contact"
        let param = ["ten_lienhe":name,
                     "sdt_lienhe":mobile,
                     "email_lienhe": email,
                     "title_lienhe":title,
                     "conten_lienhe":content] as Dictionary <String, Any>
        postRequestWith(urlString: urlString, params: param) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
    func getBenefit(completion:@escaping ((Dictionary<String, Any>?, String?)->())){
        let urlString = "\(self.getCurrentDomain())benefit"
        
        getRequestWith(urlString: urlString) { (response, error, errMes) in
            if error == nil && errMes == nil{
                let data = response?["data"] as! Dictionary<String, Any>
                completion(data, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errMes)
                }
            }
        }
        
    }
    
    func getWhatIsTimeShare(completion:@escaping ((Dictionary<String, Any>?, String?)->())){
        let urlString = "\(self.getCurrentDomain())about"
        
        getRequestWith(urlString: urlString) { (response, error, errMes) in
            if error == nil && errMes == nil{
                let data = response?["data"] as! Dictionary<String, Any>
                completion(data, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errMes)
                }
            }
        }
        
        
    }
    func getAboutUs(completion:@escaping ((Dictionary<String, Any>?, String?)->())){
        let urlString = "\(self.getCurrentDomain())introduce"
        getRequestWith(urlString: urlString) { (response, error, errMes) in
            if error == nil && errMes == nil{
                let data = response?["data"] as! Dictionary<String, Any>
                completion(data, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errMes)
                }
            }
        }
        
    }
    func getFAQs(completion:@escaping (([Dictionary<String, Any>]?, String?)->())){
        let urlString = "\(self.getCurrentDomain())faq"
        getRequestWith(urlString: urlString) { (response, error, errMes) in
            if error == nil && errMes == nil{
                let data = response?["data"] as Any
                let dataArray = data as? Array<Any>
                completion(dataArray as! [Dictionary<String, Any>]?, nil)
            }
            else{
                if error != nil{
                    completion(nil, self.serverErrorMes)
                }
                else {
                    completion(nil, errMes)
                }
            }
        }
        
    }
    
    // get with url
    func getRequestWith(urlString : String, completion : @escaping (Dictionary<String, Any>?, _ err : Error?, String?) -> ()){
        
        let url = NSURL(string: urlString)
        var request = URLRequest(url: url as! URL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                completion(nil, error, nil)
            }else{
                do{
                    if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String : Any]{
                        
                        let responseError = jsonDictionaries["error"] as! NSNumber
                        
                        if responseError != 0 {
                            let errorMes = jsonDictionaries["message"] as! String
                            DispatchQueue.main.sync {
                                completion(nil, nil, errorMes)
                            }
                            
                        }else{
                            DispatchQueue.main.sync {
                                completion(jsonDictionaries, nil, nil)
                            }
                        }
                    }
                }catch let jsonError{
                    print(jsonError)
                }
            }
            }.resume()
    }
    
    
    // post request
    func postRequestWith(urlString : String, params : Dictionary<String, Any>, completion: @escaping (Dictionary<String, Any>?, _ err : Error?, String? ) ->()){
        
        let url = NSURL(string: urlString)
        var request = URLRequest(url: url as! URL)
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        }catch{
            print(error.localizedDescription)
        }
        
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                completion(nil, error, nil)
                
            }else{
                do{
                    if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String : Any]{
                        let responseError = jsonDictionaries["error"] as! NSNumber
                        
                        if responseError != 0 {
                            let errorMes = jsonDictionaries["message"] as! String
                            DispatchQueue.main.sync {
                                completion(nil, nil, errorMes)
                            }
                            
                        }else{
                            DispatchQueue.main.sync {
                                completion(jsonDictionaries, nil, nil)
                            }
                        }
                    }
                }catch let jsonError{
                    print(jsonError)
                }
            }
            }.resume()
        
    }
    
    // parse data list
    func getResortFrom(dictionary : Any) -> [Resort]{
        let arrayData = dictionary as? Array<Any>
        var resorts : [Resort] = [Resort]()
        for resortData in arrayData!{
            let resort = Resort(data: resortData as! Dictionary<String, Any>)
            resorts.append(resort)
        }
        return resorts
    }
    
    func getRecruitmentsFrom(dictionary : Any) -> [Recruitment] {
        let arrayData = dictionary as? Array<Any>
        var recruitments : [Recruitment] = [Recruitment]()
        for resortData in arrayData!{
            let recruitment = Recruitment(data: resortData as! Dictionary<String, Any>)
            recruitments.append(recruitment)
        }
        return recruitments
    }
    
    func getOffersFrom(dictionary : Any) ->[Offer]{
        let arrayData = dictionary as? Array<Any>
        var offers : [Offer] = [Offer]()
        for resortData in arrayData!{
            let offer = Offer(data: resortData as! Dictionary<String, Any>)
            offers.append(offer)
        }
        return offers
    }
    
    func getVouchersFrom(dictionary : Any) -> [Voucher]{
        let arrayData = dictionary as? Array<Any>
        var vouchers : [Voucher] = [Voucher]()
        for vouchersData in arrayData!{
            let voucher = Voucher(data: vouchersData as! Dictionary<String, Any>)
            vouchers.append(voucher)
        }
        return vouchers
    }
    
    func getBooksFrom(dictionary : Any) -> [BookInfo]{
        let arrayData = dictionary as? Array<Any>
        var books : [BookInfo] = [BookInfo]()
        for bookData in arrayData!{
            let bookInfo = BookInfo(data: bookData as! Dictionary<String, Any>)
            books.append(bookInfo)
        }
        return books
    }
    
    func getCountriesFrom(dictionary : Any) -> [Country]{
        let arrayData = dictionary as? Array<Any>
        var countries : [Country] = [Country]()
        for countryData in arrayData!{
            let country = Country(data: countryData as! Dictionary<String, Any>)
            countries.append(country)
        }
        return countries
    }
    
    func getProvincesFrom(dictionary : Any) -> [Province]{
        let arrayData = dictionary as? Array<Any>
        var provinces : [Province] = [Province]()
        for countryData in arrayData!{
            let country = Province(data: countryData as! Dictionary<String, Any>)
            provinces.append(country)
        }
        return provinces
    }
    func getTypesResort(dictionary : Any) ->[TypeResort]{
        
        let arrayData = dictionary as? Array<Any>
        var types : [TypeResort] = [TypeResort]()
        for typeData in arrayData!{
            let type = TypeResort(data: typeData as! Dictionary<String, Any>)
            types.append(type)
        }
        return types
    }
    
    
    func getCurrentDomain() -> String{
        return LanguageManager.sharedInstance.localizedString(string: "domain")!
    }
}
