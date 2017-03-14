//
//  SearchResultCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/9/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SearchResultCell: BaseCell {

    var resort : Resort?{
        didSet{
            if (resort?.images?.count)! > 0 {
                imageView.loadImageUsingUrlString(urlString: (resort?.images?[0])!)
                labelName.text = resort?.name
                labelAddress.text = resort?.address
            }
        }
    }
    
    let imageView : CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "resort")
        return iv
    }()
    
    let labelName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let iconAddress : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "adress_icon"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let labelAddress : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        addSubview(imageView)
        addSubview(labelName)
        addSubview(iconAddress)
        addSubview(labelAddress)
        backgroundColor = UIColor.white
        
        addConstraintWithFormat(format: "V:|-20-[v0]-20-|", views: imageView)
        addConstraintWithFormat(format: "H:|-20-[v0(80)]-10-[v1]-10-|", views: imageView, labelName)
        
        labelName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        iconAddress.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        iconAddress.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconAddress.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconAddress.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        labelAddress.centerYAnchor.constraint(equalTo: iconAddress.centerYAnchor, constant: 3).isActive = true
        labelAddress.leftAnchor.constraint(equalTo: iconAddress.rightAnchor, constant: 5).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
    }
    

}
