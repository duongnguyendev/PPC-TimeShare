//
//  Resort.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/16/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Resort: NSObject {
    var resortId : String?
    var name : String?
    var address: String?
    var price: String?
    var introduce: String?
    var type: String?
    var lat: Double?
    var lng: Double?
    var service: String?
    var images : [String]?
    var equipment : String?
    
    init(data : Dictionary<String, Any>) {
        let idNum = data["id"]
        let latNum = data["lat"] as! NSString
        self.lat = latNum.doubleValue
        let lngNum = data["lng"] as! NSString
        self.lng = lngNum.doubleValue
        self.resortId = String(describing: idNum!)
        self.name = data["name"] as! String?
        self.address = data["address"] as! String?
        self.price = data["price"] as! String?
        self.introduce = data["introduce"] as! String?
        self.type = data["resort_type"] as! String?
    
        self.service = data["service"] as! String?
        self.equipment = data["equipment"] as! String?
        self.images = data["images"] as! [String]?
        
    }
}
