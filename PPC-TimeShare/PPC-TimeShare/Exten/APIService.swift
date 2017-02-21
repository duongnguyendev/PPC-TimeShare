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
    let baseUrl = "http://ppctimeshare.hbbsolution.com/api"
    
    func fetchResort(completion : @escaping ([Resort])->()){
        let urlString = "\(baseUrl)/resort/all?page=2"
        let url = NSURL(string: urlString)
        var request = URLRequest(url: url as! URL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error as Any)
            }else{
                do{
                    if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String : Any]{
                        
                        DispatchQueue.main.sync {
                            let resortsDic = jsonDictionaries["data"]
                            let resorts = self.getResortFrom(dictonary: resortsDic as Any)
                            completion(resorts)
                        }                        
                    }
                }catch let jsonError{
                    print(jsonError)
                }
            }
        }.resume()
    }
    
    func getResortFrom(dictonary : Any) -> [Resort]{
        let arrayData = dictonary as? Array<Any>
        var resorts : [Resort] = [Resort]()
        for resortData in arrayData!{
            let resort = Resort(data: resortData as! Dictionary<String, Any>)
            resorts.append(resort)
        }
        return resorts
    }
    
    
}
