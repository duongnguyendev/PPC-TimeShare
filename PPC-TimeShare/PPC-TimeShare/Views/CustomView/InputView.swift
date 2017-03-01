//
//  InputView.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit



enum InputType {
    case normal
    case email
    case password
}

protocol InputViewDelegate {
    func input(edited: Bool)
}

class InputView: BaseView {
    
    var delegate : InputViewDelegate?
    
    let margin : CGFloat = 20.0
    let iconSize : CGFloat = 20.0
    
    var editAble : Bool?{
        didSet{
            self.textField.isUserInteractionEnabled = editAble!
            if editAble! {
                self.textField.becomeFirstResponder()
            }
            
        }
    }
    
    var type : InputType?{
        didSet{
            if type == InputType.password {
                textField.isSecureTextEntry = true
            }
        }
    }
    var hint : String?{
        didSet{
            textField.placeholder = hint
        }
    }
    var iconName : String?{
        didSet{
            imageIcon.image = UIImage(named: iconName!)
        }
    }
    var string : String?{
        didSet{
            textField.text = string
        }
    }
    let imageIcon : UIImageView = {
        let image = UIImageView(image: UIImage(named: "account"))
        return image
    }()
    
    let textField : UITextField = {
        let tF = UITextField()
        tF.font = UIFont(name: "Roboto-Light", size: 14)
        return tF
    }()
    let editControllButton : BaseButton = {
        let button = BaseButton()
        button.setImage(UIImage(named: "icon_update"), for: .normal)
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return button
    }()
    override func setupView(){
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageIcon)
        addSubview(textField)
        addSubview(editControllButton)
        imageIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        imageIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        editControllButton.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        editControllButton.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-[v1]-\(margin)-[v2]-\(margin)-|", views: imageIcon, textField, editControllButton)
        
        addConstraint(NSLayoutConstraint(item: imageIcon, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: editControllButton, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1, constant: 0))
        editControllButton.isHidden = true
    }
    
    func handleEditButton(){
        self.editAble = !editAble!
        if (self.delegate != nil) {
            self.delegate?.input(edited: true)
        }
    }
}
