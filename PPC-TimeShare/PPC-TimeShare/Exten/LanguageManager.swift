//
//  LanguageManager.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class LanguageManager: NSObject {
    
    static let sharedInstance = LanguageManager()
    static let string = "test"
    
    func localizedString(string: String) -> String?{
        return string
    }
    
}
