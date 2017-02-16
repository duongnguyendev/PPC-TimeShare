//
//  ResortCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class InfoCell: BaseCell {
    
    override func setupView() {
        backgroundColor = UIColor.clear
        addSubview(contentV)
        addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: contentV)
        addConstraintWithFormat(format: "V:|[v0]-\(margin)-|", views: contentV)
        contentV.layer.shadowColor = UIColor.gray.cgColor
        contentV.layer.shadowOpacity = 0.5
        contentV.layer.shadowOffset = CGSize(width: 3, height: 3)
        contentV.layer.shadowRadius = 3
    }
    let margin : CGFloat = 25.0
    let pedding : CGFloat = 10.0

    let contentV : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    let imageView : UIImageView = {
        let imV = UIImageView(image: UIImage(named: "resort"))
        //        imV.contentMode = .scaleAspectFit
        return imV
    }()
    
    func addContent(){
        let imageHeight = frame.size.height / 16 * 9
        contentV.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentV.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        contentV.addConstraintWithFormat(format: "H:|[v0]|", views: imageView)
    }
    
}

class ResortCell: InfoCell {
    
    var resort : Resort?{
        didSet{
            nameLabel.text = resort?.name
            addressLabel.text = resort?.address
            
        }
    }
    
    override func setupView() {
        super.setupView()
        addContent()
    }
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
    let priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.red
        label.text = "2.000 USD"
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
        contentV.addSubview(priceLabel)
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding)-[v0]|", views: nameLabel)
        nameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding)-[v0]-\(self.pedding)-|", views: addressLabel)
        addressLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 0).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding)-[v0]-\(self.pedding)-|", views: priceLabel)
        priceLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        textViewIntro.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -5).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-5-[v0]-5-|", views: textViewIntro)
        textViewIntro.bottomAnchor.constraint(equalTo: contentV.bottomAnchor, constant: 0).isActive = true
        
        
        
    }

}
