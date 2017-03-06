//
//  Voucher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Voucher: NSObject {
    var voucherId : NSNumber?
    var name : String?
    var cost : String?
    var date : String?
    var userId : NSNumber?
    var total : NSNumber?
    
    init(data : Dictionary<String, Any>) {
        
         voucherId = data["id"] as! NSNumber?
         name = data["name"] as! String?
         cost = data["cost"] as! String?
         date = data["date"] as! String?
         userId = data["id_user"] as! NSNumber?
         total = data["total"] as! NSNumber?
    }
}
