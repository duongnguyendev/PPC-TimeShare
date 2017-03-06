//
//  HistoryCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HistoryCell: BaseCell {
    
    var bookInfo : BookInfo?{
        didSet{
            self.labelName.text = bookInfo?.resort?.name
            self.labelAddress.text = bookInfo?.resort?.address
            self.labelAddress.text = bookInfo?.resort?.price
        }
    }
    
    let labelName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        label.text = "Name Resort"
        return label
    }()
    let iconAddress : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "adress_icon"))
        return iv
    }()
    
    let iconPrice : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "price_icon"))
        return iv
    }()
    
    let labelAddress : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.textColor = UIColor.red
        return label
    }()
    
    let labelPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.textColor = UIColor.red
        return label
    }()

    override func setupView() {
        addSubview(labelName)
        addSubview(iconAddress)
        addSubview(iconPrice)
        addSubview(labelAddress)
        addSubview(labelPrice)
        
        addConstraintWithFormat(format: "V:|[v0(20)]-5-[v1(20)][v2(20)]|", views: labelName, iconAddress, iconPrice)
        
        

    }

}
