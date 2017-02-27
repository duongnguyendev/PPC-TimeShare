//
//  User.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class User: NSObject {
    var userId : NSNumber?
    var userName : String?
    var email : String?
    var mobileNumber : String?
    var password : String?
    var avartarUrl : String?
    var address : String?
    var gender : Gender?
    var token: String?
    
    override init() {
         userId = 0
         userName = ""
         email = ""
         mobileNumber = ""
         password = ""
         avartarUrl = ""
         address = ""
         gender = Gender(genderId: 1, genderValue: "Male")
         token  = ""
    }

    init(data: Dictionary<String, Any>) {
        userId = data["id"] as! NSNumber?
        userName = data["hoten"] as! String?
        email = data["tendangnhap"] as! String?
        mobileNumber = data["dienthoai"] as! String?
        address = data["diachi"] as! String?
        gender = Gender(genderId: 1)
        token  = data["token"] as! String?
        if let avatar = data["avatar"]{
            avartarUrl = avatar as? String
        }
        
    }
    func toDictionary() -> Dictionary<String, Any>?{
        
        let dic = ["id":self.userId!,
                   "hoten":self.userName!,
                   "tendangnhap":self.email!,
                   "dienthoai":self.mobileNumber!,
                   "password":"",
                   "avatar":self.avartarUrl ?? "",
                   "diachi":self.address!,
                   "gender":self.gender?.genderId as Any,
                   "token":self.token!] as Dictionary<String, Any>
        return dic
        
    }
}
