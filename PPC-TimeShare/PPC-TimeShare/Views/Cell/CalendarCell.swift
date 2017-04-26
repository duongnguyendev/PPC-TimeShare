//
//  CalendarCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 4/25/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

protocol CalendarCellDelegate {
    func select(date : Date)
}

class CalendarCell: BaseCell {
    
    var delegate : CalendarCellDelegate?
    
    var weekNumber : Int? {
        didSet{
            if weekNumber! % 2 == 0{
                self.backgroundColor = UIColor.white
            }else{
                self.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
            }
            weekTitle.text = "\(weekNumber ?? 0)"
        }
    }
    var weekItem : Week?{
        didSet{
            if let friday = weekItem?.friday {
                buttonFriday.setTitle(friday.dayMonthToString(), for: .normal)
            }
            else{
                buttonFriday.setTitle("", for: .normal)
            }
            if let saturday = weekItem?.saturday{
                buttonSaturday.setTitle(saturday.dayMonthToString(), for: .normal)
            }else{
                buttonSaturday.setTitle("", for: .normal)
            }
            if let sunday = weekItem?.sunday{
                buttonSunday.setTitle(sunday.dayMonthToString(), for: .normal)
            }else{
                buttonSunday.setTitle("", for: .normal)
            }
        }
    }

    private let weekTitle : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont(name: "Roboto-Regular", size: 16)
        return lb
    }()
    
    private let buttonFriday : BaseButton = {
        let bt = MyButton()
        bt.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        bt.setTitleColor(UIColor.rgb(red: 3, green: 123, blue: 255), for: .normal)
        return bt
    }()
    private let buttonSaturday : BaseButton = {
        let bt = MyButton()
        bt.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        bt.setTitleColor(UIColor.rgb(red: 3, green: 123, blue: 255), for: .normal)
        return bt
    }()
    private let buttonSunday : BaseButton = {
        let bt = MyButton()
        bt.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        bt.setTitleColor(UIColor.rgb(red: 3, green: 123, blue: 255), for: .normal)
        return bt
    }()
    
    override func setupView() {
        addSubview(weekTitle)
        addSubview(buttonFriday)
        addSubview(buttonSaturday)
        addSubview(buttonSunday)
        
        addConstraint(NSLayoutConstraint(item: weekTitle, attribute: .width, relatedBy: .equal, toItem: buttonFriday, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: weekTitle, attribute: .width, relatedBy: .equal, toItem: buttonSaturday, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: weekTitle, attribute: .width, relatedBy: .equal, toItem: buttonSunday, attribute: .width, multiplier: 1, constant: 0))
        
        addConstraintWithFormat(format: "V:|-1-[v0]|", views: weekTitle)
        addConstraintWithFormat(format: "V:|-1-[v0]|", views: buttonFriday)
        addConstraintWithFormat(format: "V:|-1-[v0]|", views: buttonSaturday)
        addConstraintWithFormat(format: "V:|-1-[v0]|", views: buttonSunday)
        
        addConstraintWithFormat(format: "H:|-1-[v0]-1-[v1]-1-[v2]-1-[v3]-1-|", views: weekTitle, buttonFriday, buttonSaturday, buttonSunday)
        
        buttonSunday.addTarget(self, action: #selector(haldleSunday), for: .touchUpInside)
        buttonFriday.addTarget(self, action: #selector(haldleFriday), for: .touchUpInside)
        buttonSaturday.addTarget(self, action: #selector(haldleSaturday), for: .touchUpInside)
        
    }
    
    func haldleFriday() {
        if self.delegate != nil && self.weekItem?.friday != nil{
            self.delegate?.select(date: (self.weekItem?.friday)!)
        }
    }
    func haldleSaturday() {
        if self.delegate != nil && self.weekItem?.saturday != nil{
            self.delegate?.select(date: (self.weekItem?.saturday)!)
        }
    }
    func haldleSunday() {
        if self.delegate != nil && self.weekItem?.sunday != nil{
            self.delegate?.select(date: (self.weekItem?.sunday)!)
        }
    }
}
