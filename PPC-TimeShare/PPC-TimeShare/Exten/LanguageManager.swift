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
    var bundle : Bundle?
    
    override init() {
        super.init()
        let languageCode = self.getCurrentLanguage().languageCode
        let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        bundle = Bundle(path: bundlePath!)
    }
    func localizedString(string: String) -> String?{
        
        return NSLocalizedString(string, bundle: bundle!, comment: "")
    }
    
    func setCurrentLanguage(language : Language){
        UserDefaults.standard.set([language.languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        let bundlePath = Bundle.main.path(forResource: language.languageCode, ofType: "lproj")
        bundle = Bundle(path: bundlePath!)
    }
    
    func getCurrentLanguage() -> Language {
        let languageCode = Locale.preferredLanguages[0]
        var language : Language?
        if languageCode != "vi"{
            language = Language(languageCode: "en", language: "English")
        }else{
            language = Language(languageCode: "vi", language: "Tiếng Việt")
        }
//        var language = Language()
        
        return language!
    }
}
