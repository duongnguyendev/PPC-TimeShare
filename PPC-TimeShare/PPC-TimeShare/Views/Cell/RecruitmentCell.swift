//
//  RecruitmentCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class RecruitmentCell: BaseCell {

    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(labelTitle)
        addSubview(labelAddress)
        addSubview(imageArround)
        
        addConstraint(NSLayoutConstraint(item: labelTitle, attribute: .height, relatedBy: .equal, toItem: labelAddress, attribute: .height, multiplier: (3 / 2), constant: 0))
        addConstraintWithFormat(format: "V:|-5-[v0][v1]-5-|", views: labelTitle, labelAddress)
        addConstraintWithFormat(format: "H:|-20-[v0][v1(\(iconSize))]-10-|", views: labelTitle, imageArround)
        
        imageArround.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        imageArround.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        labelAddress.leftAnchor.constraint(equalTo: labelTitle.leftAnchor, constant: 0).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: imageArround.leftAnchor, constant: 0).isActive = true
    }
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Recruit Sale"
        label.textColor = UIColor.red
        return label
    }()
    let labelAddress : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "123 Holywood, Los Angerles, USA"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = UIColor.red
        return label
    }()
    let imageArround : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "account"))
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    

}
