//
//  ResortInfoView.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ResortInfoView: UIScrollView {

    let margin : CGFloat = 20
    let iconSize : CGFloat = 20
//    var estimatedRect : CGRect?
    let textTemp = "Located in the tranquil southern coast of Vietnam near Lang Cô Bay, retreat to this intimate collection of stunning pool villas in Banyan Tree Lang Cô, Central Vietnam. Step into opulent villas reminiscent of past Vietnamese dynasties complete with sophisticated modern amenities.\n\nSurrounded by eco-diverse mountains, spectacular national parks and awe-inspiring UNESCO World Heritage Sites, explore the cultural riches of Indochina, relax on the private golden beach or indulge yourself in a time-honoured Asian spa treatment.\n\nRetreat, rejuvenate and discover, all at Banyan Tree Lang Cô, Central Vietnam.Located in the tranquil southern coast of Vietnam near Lang Cô Bay, retreat to this intimate collection of stunning pool villas in Banyan Tree Lang Cô, Central Vietnam. Step into opulent villas reminiscent of past Vietnamese dynasties complete with sophisticated modern amenities.\n\nSurrounded by eco-diverse mountains, spectacular national parks and awe-inspiring UNESCO World Heritage Sites, explore the cultural riches of Indochina, relax on the private golden beach or indulge yourself in a time-honoured Asian spa treatment.\n\nRetreat, rejuvenate and discover, all at Banyan Tree Lang Cô, Central Vietnam."
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    var textContentHeightContraint : NSLayoutConstraint?
    
    let labelName : UILabel = {
        let label = UILabel()
        label.text = "Nem Resort"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconAddress : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "adress_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    let iconPrice : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "price_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let labelAddress : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "123 Holywood, Los Angerles, USA"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        return label
    }()
    
    let labelPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "2000 USD"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        return label
    }()
    let textViewContent : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
//        textView.text = textTemp
        return textView
    }()
    func setupView(){
        
        textViewContent.text = textTemp
        addSubview(labelName)
        addSubview(iconAddress)
        addSubview(labelAddress)
        addSubview(iconPrice)
        addSubview(labelPrice)
        addSubview(textViewContent)

        if let window = UIApplication.shared.keyWindow{
            let width = window.frame.size.width
            let size = CGSize(width: width - margin - margin, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedRect = NSString(string: textTemp).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12)], context: nil)
            addConstraintWithFormat(format: "V:|[v0(30)][v1(30)][v2(30)][v3(\((estimatedRect.height)))]-\(margin)-|", views: labelName, labelAddress,labelPrice, textViewContent)
            
            labelName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
            labelName.widthAnchor.constraint(equalToConstant: width - margin).isActive = true
            
            iconAddress.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            iconAddress.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            iconAddress.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
            addConstraint(NSLayoutConstraint(item: iconAddress, attribute: .centerY, relatedBy: .equal, toItem: labelAddress, attribute: .centerY, multiplier: 1, constant: 0))
            
            labelAddress.leftAnchor.constraint(equalTo: iconAddress.rightAnchor, constant: 5).isActive = true
            labelAddress.widthAnchor.constraint(equalToConstant: width - margin - 20).isActive = true
            
            iconPrice.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            iconPrice.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            iconPrice.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
            addConstraint(NSLayoutConstraint(item: iconPrice, attribute: .centerY, relatedBy: .equal, toItem: labelPrice, attribute: .centerY, multiplier: 1, constant: 0))
            
            labelPrice.leftAnchor.constraint(equalTo: iconPrice.rightAnchor, constant: 5).isActive = true
            labelPrice.widthAnchor.constraint(equalToConstant: width - margin).isActive = true
            
            textViewContent.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
            textViewContent.widthAnchor.constraint(equalToConstant: width - 15 - 15).isActive = true
        }

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
