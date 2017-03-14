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
    let imageView : CustomImageView = {
        let imV = CustomImageView(image: UIImage(named: "resort"))
        return imV
    }()
    
    func addContent(){
        let imageHeight = frame.size.width / 16 * 9
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
            adressLabel.text = resort?.address
            if (resort?.images?.count)! > 0{
                self.imageView.loadImageUsingUrlString(urlString: (resort?.images?[0])!)
            }
            priceLabel.text = resort?.price
            textViewIntro.text = resort?.introduce
        }
    }
    
    override func setupView() {
        super.setupView()
        addContent()
    }
    let adressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.textColor = UIColor.red
        return label
    }()
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        return label
    }()
    let priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.textColor = UIColor.red
        return label
    }()
    
    
    let textViewIntro : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont(name: "Roboto-Light", size: 13)
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let iconAdress : UIImageView = {
        let imv = UIImageView(image: UIImage(named: "adress_icon"))
        return imv
    }()
    let iconPrice : UIImageView = {
        let imv = UIImageView(image: UIImage(named: "price_icon"))
        return imv
    }()
    override func addContent(){
        
        super.addContent()
        
        contentV.addSubview(adressLabel)
        contentV.addSubview(nameLabel)
        contentV.addSubview(textViewIntro)
        contentV.addSubview(priceLabel)
        contentV.addSubview(iconAdress)
        contentV.addSubview(iconPrice)
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding)-[v0]|", views: nameLabel)
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // address
        iconAdress.heightAnchor.constraint(equalToConstant: 20).isActive = true
        contentV.addConstraint(NSLayoutConstraint(item: iconAdress, attribute: .centerY, relatedBy: .equal, toItem: adressLabel, attribute: .centerY, multiplier: 1, constant: 0))

        adressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding - 2)-[v0(20)][v1]-\(self.pedding)-|", views: iconAdress, adressLabel)
        adressLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //price
        iconPrice.heightAnchor.constraint(equalToConstant: 20).isActive = true
        contentV.addConstraint(NSLayoutConstraint(item: iconPrice, attribute: .centerY, relatedBy: .equal, toItem: priceLabel, attribute: .centerY, multiplier: 1, constant: 0))
        
        priceLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 0).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-\(self.pedding - 2)-[v0(20)][v1]-\(self.pedding)-|", views:iconPrice, priceLabel)
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        textViewIntro.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -5).isActive = true
        contentV.addConstraintWithFormat(format: "H:|-5-[v0]-5-|", views: textViewIntro)
        textViewIntro.bottomAnchor.constraint(equalTo: contentV.bottomAnchor, constant: 0).isActive = true
        
        
        
    }

}
