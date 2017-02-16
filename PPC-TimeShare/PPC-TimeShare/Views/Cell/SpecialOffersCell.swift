//
//  SpecialOffersCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SpecialOffersCell: InfoCell {
    
    override func setupView() {
        
        super.setupView()
        
        addContent()
    }
    let iconAddress : UIImageView = {
        let imV = UIImageView(image: UIImage(named: "resort"))
        //        imV.contentMode = .scaleAspectFit
        return imV
        
    }()
    let textViewIntro : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "There was a time when the great Australian dream was a family home on a quarter acre book. Now it seems the aussie dream..."
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 13)
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    override func addContent(){
        super.addContent()
        
        contentV.addSubview(textViewIntro)
        
        textViewIntro.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-5-[v0]-5-|", views: textViewIntro)
        textViewIntro.bottomAnchor.constraint(equalTo: contentV.bottomAnchor, constant: 0).isActive = true

    }}
