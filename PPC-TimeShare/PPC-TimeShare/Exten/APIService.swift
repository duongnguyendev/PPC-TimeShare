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
    let baseUrl = "http://ppctimeshare.hbbsolution.com/api/vi"
    
    func fetchResortAll(completion : @escaping ([Resort]?, _ errorMessage : String?)->()){
        let urlString = "\(baseUrl)/resort/all?page=1"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil)
            }
            else{
                if error != nil{
                    completion(nil, "Can't connect to server")
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
            
        }
    }
    
    func fetchResortNew(completion : @escaping ([Resort]?, _ errorMessage : String?)->()){
        let urlString = "\(baseUrl)/resort/new"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            
            if error == nil && errorMes == nil {
                let resortsDic = response?["data"]
                let resorts = self.getResortFrom(dictionary: resortsDic as Any)
                completion(resorts, nil)
            }
            else{
                if error != nil{
                    completion(nil, "Can't connect to server")
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
            
        }
    }
    
    func getRecruitments(completion : @escaping ([Recruitment]?, String?)->()){
        let urlString = "\(baseUrl)/recruitment"
        self.getRequestWith(urlString: urlString) { (response, error, errorMes) in
            if error == nil && errorMes == nil {
                let recruitmentsDic = response?["data"]
                let recruitments = self.getRecruitmentsFrom(dictionary: recruitmentsDic as Any)
                completion(recruitments, nil)
            }
            else{
                if error != nil{
                    completion(nil, "Can't connect to server")
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
    }
    
    func requestSignUp(user : User, completion : @escaping (User?, String?)->()){
        
        let urlString = "\(baseUrl)/register"
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
                    completion(nil, "Can't connect to server")
                }
                else {
                    completion(nil, errorMes)
                }
                
            }
        }
    }
    
    func requestSignIn(email: String, passWord : String, completion: @escaping (User?, String?) ->()){
        let urlString = "\(baseUrl)/login"
        let params = ["email":email, "password": passWord] as Dictionary<String, Any>
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                //parse data
                let userDic = response?["data"]
                let user = User(data: userDic as! Dictionary<String, Any>)
                completion(user, nil)
            }else{
                if error != nil{
                    completion(nil, "Can't connect to server")
                }else{
                    completion(nil, errorMes)
                }
            }
        }
    }
    
    func requestUpdate(user : User, completion :@escaping (User?, String?) ->()){
        let urlString = "\(baseUrl)/profile"
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
                    completion(nil, "Can't connect to server")
                }
                else{
                    completion(nil, errorMes)
                }
            }
        }
        
    }
    
    func checkEmail(email : String, completion : @escaping (String?) ->()){
        let urlString = "\(baseUrl)/check-email"
        let params = ["email": email] as Dictionary<String, Any>
        postRequestWith(urlString: urlString, params: params) { (response, error, errorMes) in
            if error == nil && errorMes == nil{
                completion(nil)
            }else{
                if error != nil{
                    completion("Can't connect to server")
                }
                else{
                    completion(errorMes)
                }
            }
        }
    }
    
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
    
    
}
