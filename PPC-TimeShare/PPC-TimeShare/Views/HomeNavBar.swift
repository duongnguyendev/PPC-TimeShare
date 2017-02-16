//
//  HomeNavBar.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HomeNavBar: UIView {
    var homeVC : HomeVC?
    let titleView : UIView = {
        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor.white
        label.text = "Home"
        label.textAlignment = .center
        return label
    }()
    let buttonUser :UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "account"), for: .normal)
        button.addTarget(self, action: #selector(handleUser), for: .touchUpInside)
        return button
    }()
    let buttonSetting : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    func handleSettings(){
        
        homeVC?.navSettingsClick()
    }
    
    func handleUser(){
        homeVC?.navUserClick()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        addSubview(buttonUser)
        addSubview(titleView)
        addSubview(buttonSetting)
        
        addConstraintWithFormat(format: "H:|-10-[v0(30)]-0-[v1]-0-[v2(30)]-10-|", views: buttonUser, titleView, buttonSetting)
        
        addConstraintWithFormat(format: "V:|[v0]|", views: titleView)
        
        buttonUser.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonUser.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0).isActive = true
        buttonSetting.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonSetting.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
