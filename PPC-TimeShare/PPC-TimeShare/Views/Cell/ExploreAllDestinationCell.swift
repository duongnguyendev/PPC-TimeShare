//
//  ExploreAllDestinationCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ExploreAllDestinationCell: InfoCell {
    
    override func setupView() {
        super.setupView()
        addContent()
    }
    let iconAddress : UIImageView = {
        let imV = UIImageView(image: UIImage(named: "resort"))
        //        imV.contentMode = .scaleAspectFit
        return imV

    }()

    let addressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "Los Angerles, USA"
        label.textColor = UIColor.red
        return label
    }()
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Name Resort"
        return label
    }()
    
    let textViewIntro : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "There was a time when the great Australian dream was a family home on a quarter acre book. Now it seems the aussie dream..."
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 11)
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    override func addContent(){
        super.addContent()
        contentV.addSubview(addressLabel)
        contentV.addSubview(nameLabel)
        contentV.addSubview(textViewIntro)
        contentV.addSubview(iconAddress)
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding)-[v0]|", views: nameLabel)
        nameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding)-[v0(15)]-5-[v1]|", views: iconAddress, addressLabel)
        iconAddress.heightAnchor.constraint(equalToConstant: 15).isActive = true
        contentV.addConstraint(NSLayoutConstraint(item: iconAddress, attribute: .centerY, relatedBy: .equal, toItem: addressLabel, attribute: .centerY, multiplier: 1, constant: 0))
        
        textViewIntro.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: -5).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-5-[v0]-5-|", views: textViewIntro)
        textViewIntro.bottomAnchor.constraint(equalTo: contentV.bottomAnchor, constant: 0).isActive = true
        
    }
    
}

