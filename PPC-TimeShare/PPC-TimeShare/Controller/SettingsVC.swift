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
    }
    
    let buttonLogout : MyButton = {
        let button = MyButton(type: UIButtonType.custom)
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentEdgeInsets.left = 20
        button.contentHorizontalAlignment = .left
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
        return button
    }()
    
    let buttonLanguage : InfoButton = {
        let button = InfoButton()
        button.title = "Languages"
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
        view.addConstraintWithFormat(format: "H:|-(-40)-[v0]|", views: buttonLanguage)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: buttonLogout)
        view.addConstraintWithFormat(format: "V:|-20-[v0(\(itemHeight))]-1-[v1(\(itemHeight))]", views: buttonLanguage, buttonLogout)
        
        view.addSubview(languageDropDown)
        
        languageDropDown.topAnchor.constraint(equalTo: buttonLanguage.bottomAnchor, constant: 1).isActive = true
        languageDropDown.rightAnchor.constraint(equalTo: buttonLanguage.rightAnchor, constant: -10).isActive = true
        languageDropDown.heightAnchor.constraint(equalToConstant: 63).isActive = true
        languageDropDown.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func handleLogoutButton(){
        UserDefaults.standard.removeObject(forKey: "currentUser")
        UserDefaults.standard.removeObject(forKey: "token")
        goHome()
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
        LanguageManager.sharedInstance.setCurrentLanguage(language: language)
        languageDropDown.hide()
        localizeString()
    }
    
    override func localizeString() {
        
        title = LanguageManager.sharedInstance.localizedString(string: "Settings")
        
    }
    override func hideKeyboarTouchupOutSide() {
        
    }

}
