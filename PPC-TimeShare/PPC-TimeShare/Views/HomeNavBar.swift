//
//  HomeNavBar.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeNavBar: BaseView {
    
    var homeVC : HomeVC?
    let titleView : UIView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    let buttonUser :UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "user_icon.png"), for: .normal)
        button.addTarget(self, action: #selector(handleUser), for: .touchUpInside)
        return button
    }()
    let buttonSetting : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "more"), for: .normal)
        button.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        return button
    }()
    
    func handleSettings(){
        
        homeVC?.navSettingsClick()
    }
    
    func handleUser(){
        homeVC?.navUserClick()
    }
    
    override func setupView() {
        backgroundColor = UIColor.appStyleColor()
        addSubview(buttonUser)
        addSubview(titleView)
        addSubview(buttonSetting)
        
        addConstraintWithFormat(format: "H:|-10-[v0(25)][v1][v2(25)]-10-|", views: buttonUser, titleView, buttonSetting)
        
        addConstraintWithFormat(format: "V:|-5-[v0]-5-|", views: titleView)
        
        buttonUser.heightAnchor.constraint(equalToConstant: 25).isActive = true
        buttonUser.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        buttonSetting.heightAnchor.constraint(equalToConstant: 25).isActive = true
        buttonSetting.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true

    }
}
