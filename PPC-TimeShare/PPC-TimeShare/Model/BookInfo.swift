//
//  BookInfo.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BookInfo: NSObject {
    var resort : Resort?
    var checkInDate : String?
    var checkOutDate : String?
    var numberAdults : Int = 0
    var numberChilds : Int = 0
    var room : Int?
    var createAt : String?
    var status : String?
    var totalPrice : String?
    var discount : String?
    var note : String?
    
    override init() {
        
    }
    
    init(data : Dictionary<String, Any>) {
        
        self.resort = Resort()
        resort?.name = data["name"] as? String
        resort?.resortId = data["id_resort"] as? NSNumber
        resort?.address = data["address"] as? String
        let image : String = (data["image"] as? String)!
        resort?.images = [image]
        resort?.price = data["resort_price"] as? String
        
        checkInDate = data["start_date"] as? String
        checkOutDate = data["end_date"] as? String
        numberAdults = Int(data["adults"] as! NSNumber)
        numberChilds = Int(data["childs"] as! NSNumber)
        createAt = data["created_at"] as! String?
        room = data["room"] as! NSNumber? as! Int?
        status = data["status"] as! String?
        totalPrice = data["total_price"] as! String?
        discount = data["discount"] as! String?
        
    }
    
}
