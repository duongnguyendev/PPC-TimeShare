//
//  Recruitment.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/24/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Recruitment: NSObject {
    var recruitmentId : NSNumber?
    var image : String?
    var date: String?
    var title: String?
    var content: String?
    
    init(data : Dictionary<String, Any>) {
        recruitmentId = data["id"] as! NSNumber?
        title = data["title"] as! String?
        date = data["date"] as! String?
        image = data["image"] as! String?
        content = data["content"] as! String?
    }
}
