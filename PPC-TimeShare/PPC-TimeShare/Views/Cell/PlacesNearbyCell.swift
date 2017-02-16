//
//  PlacesNearbyCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class PlacesNearbyCell: BaseCell {

    let icon : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "account")
        return imageView
    }()
    let titleIntroduce : UILabel = {
        let label = UILabel()
        label.text = "Name resort"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let arowImage : UIImageView = {
        let image = UIImage(named: "account")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    let distanceLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .right
        label.text = "100 Km"
        
        return label
    }()
    
    override func setupView() {
        backgroundColor = UIColor.yellow
        addSubview(icon)
        addSubview(titleIntroduce)
        addSubview(distanceLabel)
        addSubview(arowImage)
        //
        addConstraintWithFormat(format: "H:|-20-[v0(\(iconSize))]-10-[v1]-10-[v2(70)]-10-[v3(\(iconSize))]-10-|", views: icon,titleIntroduce, distanceLabel ,arowImage)
        addConstraintWithFormat(format: "V:|[v0]|", views: titleIntroduce)
        addConstraintWithFormat(format: "V:[v0(\(iconSize))]", views: icon)
        addConstraintWithFormat(format: "V:[v0(\(iconSize))]", views: arowImage)
        addConstraintWithFormat(format: "V:|[v0]|", views: distanceLabel)
        
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: arowImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: distanceLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
