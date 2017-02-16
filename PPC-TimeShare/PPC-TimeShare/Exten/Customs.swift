//
//  Customs.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HearderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    let labelHeader : UILabel = {
    
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    
    func setupView(){
        backgroundColor = UIColor.clear
        addSubview(labelHeader)
        addConstraintWithFormat(format: "V:|[v0]|", views: labelHeader)
        addConstraintWithFormat(format: "H:|-20-[v0]|", views: labelHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


