//
//  BookInfoButton.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class InfoButton: BaseButton {

    let margin : CGFloat = 20
    let iconSize : CGFloat = 20
    var dateValue : Date? {
        didSet{
            value = dateValue?.dateToString()
        }
    }
    var iconName : String?{
        didSet{
            iconImage.image = UIImage(named: iconName!)
        }
    }
    var title : String?{
        didSet{
            labelTitle.text = title
        }
    }
    var value : String?{
        didSet{
            labelValue.text = value
        }
    }
    

    let iconImage : UIImageView = {
        let imv = UIImageView(image: UIImage(named: ""))
        return imv
    }()
    let arrowImage : UIImageView = {
        let imv = UIImageView(image: UIImage(named: "arrow_expand_icon"))
        
        return imv
    }()
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.text = "Check in"
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        return label
    }()
    
    let labelValue : UILabel = {
        let label = UILabel()
        label.text = "20/02/2017"
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.textAlignment = .right
        return label
    }()
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(iconImage)
        addSubview(labelTitle)
        addSubview(labelValue)
        addSubview(arrowImage)
        
        labelValue.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        addConstraintWithFormat(format: "H:|-\(margin)-[v0(\(iconSize))]-\(margin)-[v1][v2]-\(margin)-[v3(\(iconSize))]-20-|", views: iconImage, labelTitle, labelValue, arrowImage)
        
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: labelTitle, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: labelValue, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: arrowImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }
}
