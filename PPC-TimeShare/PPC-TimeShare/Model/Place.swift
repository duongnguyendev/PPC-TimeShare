//
//  Country.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Country: NSObject {

    var countryId : NSNumber?
    var countryName : String?
    
    init(countryId : NSNumber, countryName: String) {
        self.countryId = countryId
        self.countryName = countryName
    }
    
    init(data : Dictionary<String, Any>) {
        self.countryId = data["id"] as? NSNumber
        self.countryName = data["name"] as? String
    }
}

class Province: NSObject {
    var provinceId : NSNumber?
    var provinceName : String?
    init(provinceId : NSNumber, provinceName: String) {
        self.provinceId = provinceId
        self.provinceName = provinceName
    }
    
    init(data : Dictionary<String, Any>) {
        self.provinceId = data["id"] as? NSNumber
        self.provinceName = data["name"] as? String
    }

}

class TypeResort : NSObject {
    var typeId : NSNumber?
    var typeName : String?
    
    init(data : Dictionary<String, Any>) {
        self.typeId = data["id"] as? NSNumber
        self.typeName = data["name"] as? String
    }
}
class SearchBy: NSObject {
    var searchById : NSNumber?
    var searchByName : String?
    init(searchById : NSNumber, searchByName : String){
        self.searchById = searchById
        self.searchByName = searchByName
    }
}

class FillterOption : NSObject{
    
    var country : Country?
    var province : Province?
    var type : TypeResort?
    var searchBy : SearchBy?
}
