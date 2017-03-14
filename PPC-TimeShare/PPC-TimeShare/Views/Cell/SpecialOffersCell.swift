//
//  SpecialOffersCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SpecialOffersCell: InfoCell {
    
    var offer : Offer?{
        didSet{
            self.imageView.loadImageUsingUrlString(urlString: (offer?.imageUrlString)!)
            self.textViewIntro.text = offer?.title
        }
    }
    
    override func setupView() {
        
        super.setupView()
        
        addContent()
    }
    let iconAddress : UIImageView = {
        let imV = UIImageView(image: UIImage(named: "resort"))
        return imV
        
    }()
    let textViewIntro : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
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
