//
//  IntroduceCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    
    let iconSize : CGFloat = 20

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
    }
}

class IntroduceCell : BaseCell {
    
    var item : EnumIntroduceName?{
        didSet{
            if let myItem = item{
                switch myItem {
                case EnumIntroduceName.AboutUs:
                    icon.image = UIImage(named: "about_us_icon")
                    titleIntroduce.text = LanguageManager.sharedInstance.localizedString(string: "AboutUs")
                    break
                case EnumIntroduceName.WhatISTimeshare:
                    icon.image = UIImage(named: "what_is_timeshare_icon")
                    titleIntroduce.text = LanguageManager.sharedInstance.localizedString(string: "WhatIsTimeshare")
                    break
                case EnumIntroduceName.FAQs:
                    icon.image = UIImage(named: "FAQs_icon")
                    titleIntroduce.text = LanguageManager.sharedInstance.localizedString(string: "FAQs")
                    break
                case EnumIntroduceName.PPCTimesharebusiness:
                    icon.image = UIImage(named: "PPC_timeshare_business_icon")
                    titleIntroduce.text = LanguageManager.sharedInstance.localizedString(string: "PPCTimeshareBusiness")
                    break
                case EnumIntroduceName.Benefits:
                    icon.image = UIImage(named: "benefit_icon")
                    titleIntroduce.text = LanguageManager.sharedInstance.localizedString(string: "Benefits")
                    break
                case EnumIntroduceName.ExchangeProgram:
                    icon.image = UIImage(named: "exchange_program_icon")
                    titleIntroduce.text = LanguageManager.sharedInstance.localizedString(string: "ExchangeProgram")
                    break
                }
            }
        }
    }
    
    let icon : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "account")
        return imageView
    }()
    let titleIntroduce : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let arowImage : UIImageView = {
        let image = UIImage(named: "arrow_right_icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(icon)
        addSubview(titleIntroduce)
        addSubview(arowImage)
        //
        addConstraintWithFormat(format: "H:|-20-[v0(\(iconSize))]-10-[v1]-10-[v2(\(iconSize))]-10-|", views: icon,titleIntroduce,arowImage)
        addConstraintWithFormat(format: "V:|[v0]|", views: titleIntroduce)
        addConstraintWithFormat(format: "V:[v0(\(iconSize))]", views: icon)
        addConstraintWithFormat(format: "V:[v0(\(iconSize))]", views: arowImage)
        
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: arowImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
