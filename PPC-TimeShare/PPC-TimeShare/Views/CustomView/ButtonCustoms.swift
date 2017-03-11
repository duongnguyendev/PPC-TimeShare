//
//  ButtonCustoms.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
enum HomeButtonType {
    case normal
    case system
    case listResort
    case recruitment
    case sendRequest
}
class BaseButton : UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
    
    }
}
class MyButton: BaseButton {

    override func setupView() {
        titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
    }
    
}

class TabButton: MyButton {
    let selectedView = UIView()
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                selectedView.isHidden = false
            }else{
                selectedView.isHidden = true
            }
        }
    }
    
    override func setupView() {
        titleLabel?.font = UIFont(name: "Roboto-Light", size: 14)
        setTitleColor(UIColor.rgb(red: 255, green: 200, blue: 0), for: .normal)
        setTitleColor(UIColor.rgb(red: 134, green: 0, blue: 1), for: .selected)
        
        addSubview(selectedView)
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        selectedView.backgroundColor = UIColor.rgb(red: 134, green: 0, blue: 1)
        selectedView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        selectedView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        selectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        selectedView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        selectedView.isHidden = true
    }
}

class ButtonCheckBook : BaseButton{
    
    var title: String?{
        didSet{
            self.titleView.text = title
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                statusIcon.image = UIImage(named: "check")
            }else{
                statusIcon.image = UIImage(named: "uncheck")
            }
        }
    }
    
    let statusIcon : UIImageView = {

        let iv = UIImageView(image: UIImage(named: "uncheck"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func setupView() {
        
        addSubview(statusIcon)
        addSubview(titleView)
        
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30).isActive = true
        
        statusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        statusIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        statusIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        statusIcon.rightAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: -10).isActive = true
    }
}


class HomeButtonCustom : BaseButton {
    
    var type : HomeButtonType?{
        
        didSet{
            if let mtype = type {
                switch mtype {
                case HomeButtonType.normal:
                    setupViewNomal()
                    break
                case HomeButtonType.system:
                    setupSystemView()
                    break
                case HomeButtonType.listResort:
                    setupListResortView()
                    break
                case HomeButtonType.recruitment:
                    setupRecruitmentView()
                    break
                case HomeButtonType.sendRequest:
                    setupSendRequestView()
                    break
                }
            }
        }
    }

    override func setupView() {
        addBackGround()
        addSubview(titleLabelView)
        addSubview(iconView)
    }
    var iconName : String?{
        didSet{
            iconView.image = UIImage(named: iconName!)
        }
    }
    var title : String?{
        didSet{
            titleLabelView.text = title
        }
    }
    
    var backGroundImage : String?{
        didSet{
            backGround.image = UIImage(named: backGroundImage!)
        }
    }
    
    
    let backGround : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let titleLabelView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        
        label.font = UIFont(name: "Roboto-Regular", size: 19)
        return label
        
    }()
    
    func addBackGround(){
        
        addSubview(backGround)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: backGround)
        addConstraintWithFormat(format: "V:|[v0]|", views: backGround)
        
        
    }
    
    func setupViewNomal(){
        
        iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        iconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: (1 / 3) , constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: (1 / 2) , constant: 0))
        
        titleLabelView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        titleLabelView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        titleLabelView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabelView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func setupSystemView(){
        addConstraintWithFormat(format: "H:|[v0]|", views: titleLabelView)
        addConstraintWithFormat(format: "V:|[v0]|", views: titleLabelView)
        iconView.isHidden = true
        
    }
    func setupListResortView(){
        
        iconView.isHidden = true
        let titleBackground = UIImageView(image: UIImage(named: "list_resort_text_bg"))
        addSubview(titleBackground)
        
        titleBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addConstraintWithFormat(format: "H:|[v0]|", views: titleBackground)
        
        titleLabelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabelView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabelView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        titleLabelView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        titleLabelView.font = UIFont(name: "Roboto-Medium", size: 22)
        titleLabelView.textAlignment = .left
        titleLabelView.layer.zPosition = 1
        
        
        
    }
    func setupRecruitmentView(){
        
        iconView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        titleLabelView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        addConstraintWithFormat(format: "H:|-40-[v0]-5-[v1]|", views: iconView, titleLabelView)
        titleLabelView.textAlignment = .left
        
    }
    func setupSendRequestView(){
        
        iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        iconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        titleLabelView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        titleLabelView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        titleLabelView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabelView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 0).isActive = true
        titleLabelView.textColor = UIColor.white
        
    }
}
