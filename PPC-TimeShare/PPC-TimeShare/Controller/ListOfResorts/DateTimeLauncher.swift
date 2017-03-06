//
//  DateTimeLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseLauncher: NSObject {
    
    let blackView = UIView()
    let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init() {
        super.init()
        setupContent()
    }
    
    func setupContent(){
        if let window = UIApplication.shared.keyWindow{
            
//            blackView.translatesAutoresizingMaskIntoConstraints = false
            self.blackView.isHidden = true
            self.contentView.isHidden = true
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(contentView)
            blackView.frame = window.frame
            blackView.alpha = 0
            contentView.alpha = 0
            window.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: window, attribute: .centerY, multiplier: 1, constant: 0))
            window.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0))
            
        }
    }
    
    func show(){
        self.blackView.isHidden = false
        self.contentView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.contentView.alpha = 1
        }, completion: nil)
        
    }
    func hide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.contentView.alpha = 0
        }) { (Bool) in
            self.blackView.isHidden = true
            self.contentView.isHidden = true
        }
    }
}

class DateTimeLauncher: BaseLauncher {
    let itemSize : CGFloat = 50.0
    override init() {
        super.init()
        setupContent()
    }
    
    let buttonOK : MyButton = {
        let button = MyButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        return picker
    }()

    var item : InfoButton?
    func getDateFor(item : InfoButton){
        show()
        self.item = item
        
    }
    override func setupContent(){
        super.setupContent()
        
        //contentView size
        contentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        //content item
        contentView.addSubview(buttonOK)
        
        buttonOK.addTarget(self, action: #selector(handleOKButton), for: .touchUpInside)
        
        buttonOK.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        buttonOK.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
        
        contentView.addSubview(datePicker)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: datePicker)
        contentView.addConstraintWithFormat(format: "V:|[v0][v1(40)]|", views: datePicker, buttonOK)
    }
    func handleOKButton(){
        self.item?.dateValue = datePicker.date
        hide()
    }

}
