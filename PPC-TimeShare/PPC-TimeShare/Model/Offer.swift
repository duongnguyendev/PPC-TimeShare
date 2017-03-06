//
//  Offer.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/1/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Offer: NSObject {
    var offerId : NSNumber?
    var title : String?
    var imageUrlString : String?
    var content : String?
    
    init(data : Dictionary<String, Any>) {
        offerId = data["id"] as! NSNumber?
        title = data["title"] as! String?
        imageUrlString = data["image"] as! String?
        content = data["content"] as! String?
    }
}
