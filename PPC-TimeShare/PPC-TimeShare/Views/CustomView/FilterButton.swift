//
//  FilterButton.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FilterButton: MyButton {

    var value : String?{
        didSet{
            valueView.text = value
        }
    }
    
    let valueView : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        return label
    }()
    
    let arrowImageView : UIImageView = {
        let imv = UIImageView(image: UIImage(named: "arrow_expand_icon"))
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(valueView)
        addSubview(arrowImageView)
        
        addConstraintWithFormat(format: "H:|-10-[v0]-10-[v1(20)]-10-|", views: valueView, arrowImageView)
        
        addConstraintWithFormat(format: "V:|[v0]|", views: valueView)
        addConstraintWithFormat(format: "V:|[v0]|", views: arrowImageView)
    }
    

}
