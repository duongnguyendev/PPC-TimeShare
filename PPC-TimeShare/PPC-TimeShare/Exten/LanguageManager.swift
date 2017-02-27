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
    
    override init() {
        
        let langCode = NSLocale.preferredLanguages[0]
        let bundlePath = Bundle.main.path(forResource: langCode, ofType: "lproj")
        self.bundle = Bundle(path: bundlePath!)!
    }
    var bundle : Bundle = Bundle()
    
    func localizedString(string: String) -> String?{
        
        return NSLocalizedString(string,bundle : bundle, comment: "")
    }
    
    func setCurrentLanguage(languageCode : String){
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        self.bundle = Bundle(path: bundlePath!)!
    }
    
    
}
