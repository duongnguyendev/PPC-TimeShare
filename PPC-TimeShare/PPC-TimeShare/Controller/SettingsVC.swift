//
//  SettingsVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SettingsVC: BaseViewController, DropDownDelegate {
    
    let itemHeight : CGFloat = 50.0


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let curentLanguage = LanguageManager.sharedInstance.getCurrentLanguage()
        self.buttonLanguage.value = curentLanguage.language
        if UserDefaults.standard.object(forKey: "token") == nil{
            self.buttonLogout.isHidden = true
        }
    }
    
    let buttonLogout : InfoButton = {
        let button = InfoButton()
        button.value = ""
        button.iconName = "sign_out"
        button.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
        return button
    }()
    
    let buttonLanguage : InfoButton = {
        let button = InfoButton()
        button.iconName = "icon_language"
        button.addTarget(self, action: #selector(handleLanguageButton), for: .touchUpInside)
        return button
    }()
    
    lazy var languageDropDown : DropDownLanguages = {
        let dropDown = DropDownLanguages()
        dropDown.delegate = self
        return dropDown
    }()
    override func setupView() {
        view.addSubview(buttonLanguage)
        view.addSubview(buttonLogout)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: buttonLanguage)
        view.addConstraintWithFormat(format: "H:|[v0]-(-40)-|", views: buttonLogout)
        view.addConstraintWithFormat(format: "V:|-20-[v0(\(itemHeight))]-1-[v1(\(itemHeight))]", views: buttonLanguage, buttonLogout)
        
        view.addSubview(languageDropDown)
        
        languageDropDown.topAnchor.constraint(equalTo: buttonLanguage.bottomAnchor, constant: 1).isActive = true
        languageDropDown.rightAnchor.constraint(equalTo: buttonLanguage.rightAnchor, constant: -10).isActive = true
        languageDropDown.heightAnchor.constraint(equalToConstant: 83).isActive = true
        languageDropDown.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func handleLogoutButton(){
        
        
        UserDefaults.standard.removeObject(forKey: "currentUser")
        UserDefaults.standard.removeObject(forKey: "token")
        let alert = UIAlertController(title: "", message: languageManager.localizedString(string: "LogedOut"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            self.goHome()
        }))
    }
    
    func handleLanguageButton(){
        if languageDropDown.isHidden {
            languageDropDown.show()
        }
        else{
            languageDropDown.hide()
        }
    }
    
    func selected(language: Language) {
        self.buttonLanguage.value = language.language
        languageDropDown.hide()
        localizeString()
    }
    
    override func localizeString() {
        title = LanguageManager.sharedInstance.localizedString(string: "Settings")
        buttonLogout.title = LanguageManager.sharedInstance.localizedString(string: "LogOut")
        buttonLanguage.title = LanguageManager.sharedInstance.localizedString(string: "Languages")
    }
    override func hideKeyboarTouchupOutSide() {
        
    }

}
