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

class InputView: UIView {
    
    let margin : CGFloat = 20.0
    let iconSize : CGFloat = 20.0
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    var iconName : String?{
        didSet{
            imageIcon.image = UIImage(named: iconName!)
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
    
    func setupView(){
        backgroundColor = UIColor.white
        
        addSubview(imageIcon)
        addSubview(textField)
        
        imageIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        imageIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-[v1]-\(margin)-|", views: imageIcon, textField)
        
        addConstraint(NSLayoutConstraint(item: imageIcon, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1, constant: 0))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
