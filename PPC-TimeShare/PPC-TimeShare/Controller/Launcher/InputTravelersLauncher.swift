//
//  InputNumberLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/2/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

@objc protocol InputLauncherDelegate {
 
    @objc optional func getNumberTravelers(adults : Int, childs : Int)
    @objc optional func getNumberRooms(rooms : Int)
    @objc optional func getVoucher(voucher : Voucher)
    @objc optional func getDate(date: Date)
    @objc optional func selected(year : Int)
}

class InputTravelersLauncher: BaseLauncher, UITextFieldDelegate {
    
    var delegate : InputLauncherDelegate?
    var currentChild : Int? = 0
    var currentAdult : Int? = 0
    let labelTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.appStyleColor()
        label.text = "Travelers"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var textFieldNumberAdults : UITextField = {
        let tF = UITextField()
        tF.textAlignment = .right
        tF.translatesAutoresizingMaskIntoConstraints = false
        tF.delegate = self
        tF.placeholder = "0"
        tF.borderStyle = .roundedRect
        return tF
    }()
    
    lazy var textFieldNumberChilds : UITextField = {
        let tF = UITextField()
        tF.textAlignment = .right
        tF.translatesAutoresizingMaskIntoConstraints = false
        tF.borderStyle = .roundedRect
        tF.placeholder = "0"
        tF.delegate = self
        return tF
    }()
    
    override func setupContent() {
        super.setupContent()
        
        let labelAdults = UILabel()
        let labelChilds = UILabel()
        labelAdults.translatesAutoresizingMaskIntoConstraints = false
        labelChilds.translatesAutoresizingMaskIntoConstraints = false
        labelChilds.text = "Childs"
        labelAdults.text = "Adults"
        
        //contentView size
        contentView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.blackView.centerYAnchor, constant: -50).isActive = true
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelAdults)
        contentView.addSubview(labelChilds)
        contentView.addSubview(textFieldNumberAdults)
        contentView.addSubview(textFieldNumberChilds)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: labelTitle)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0(50)]-5-[v1]-10-|", views:labelAdults,  textFieldNumberAdults)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0(50)]-5-[v1]-10-|", views:labelChilds, textFieldNumberChilds)
        
        contentView.addConstraintWithFormat(format: "V:|[v0(40)]-10-[v1(30)]-10-[v2(30)]", views: labelTitle, textFieldNumberAdults, textFieldNumberChilds)
        
        labelAdults.centerYAnchor.constraint(equalTo: textFieldNumberAdults.centerYAnchor, constant: 0).isActive = true
        labelChilds.centerYAnchor.constraint(equalTo: textFieldNumberChilds.centerYAnchor, constant: 0).isActive = true
        
    }
    override func handleOKButton() {
        if self.delegate != nil {
            if let numberAdults = Int(textFieldNumberAdults.text!){
                // numberAdults not nil
                if let numberChilds = Int(textFieldNumberChilds.text!){
                    // numberChilds not nil
                    self.delegate?.getNumberTravelers!(adults: numberAdults, childs: numberChilds)
                    self.hide()
                }else{
                    // number childs nil
                    self.delegate?.getNumberTravelers!(adults: numberAdults, childs: 0)
                    self.hide()
                }
                
            }else{
                if let numberChilds = Int(textFieldNumberChilds.text!){
                    // numberChilds not nil
                    self.delegate?.getNumberTravelers!(adults: 0, childs: numberChilds)
                    self.hide()
                }else{
                    // number childs nil
                    self.delegate?.getNumberTravelers!(adults: 0, childs: 0)
                    self.hide()
                }
            }
        }
    }
    override func handleCancelButton() {
        if self.delegate != nil {
            self.delegate?.getNumberTravelers!(adults: currentAdult!, childs: currentChild!)
        }
        self.hide()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            return true
        }
        else{
            if (Int(string) != nil) && (textField.text?.characters.count)! < 4{
                return true
            }
        }
        
        return false
    }
    
    override func show() {
        super.show()
        self.textFieldNumberAdults.becomeFirstResponder()
    }
    
    
}

class InputRoomLauncher: BaseLauncher, UITextFieldDelegate {
    
    var delegate : InputLauncherDelegate?
    var currentRome : Int? = 0
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.button1Collor()
        label.text = LanguageManager.sharedInstance.localizedString(string: "QuantityOfRoom")
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var textFieldNumbersRoom : UITextField = {
        let tF = UITextField()
        tF.textAlignment = .right
        tF.translatesAutoresizingMaskIntoConstraints = false
        tF.delegate = self
        tF.placeholder = "0"
        tF.borderStyle = .roundedRect
        return tF
    }()
    
    override func setupContent() {
        super.setupContent()
        
        
        //contentView size
        contentView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.blackView.centerYAnchor, constant: -50).isActive = true
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(textFieldNumbersRoom)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: labelTitle)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views:textFieldNumbersRoom)
        
        contentView.addConstraintWithFormat(format: "V:|[v0(40)]-10-[v1(30)]", views: labelTitle, textFieldNumbersRoom)
    }
    
    override func handleOKButton() {
        if self.delegate != nil , textFieldNumbersRoom.text != ""{
            self.delegate?.getNumberRooms!(rooms: Int(textFieldNumbersRoom.text!)!)
        }else{
            self.delegate?.getNumberRooms!(rooms: self.currentRome!)
        }
        self.hide()
    }
    override func handleCancelButton() {
        if self.delegate != nil{
            self.delegate?.getNumberRooms!(rooms: currentRome!)
        }
        self.hide()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            return true
        }
        else{
            if (Int(string) != nil) && (textField.text?.characters.count)! < 4{
                return true
            }
        }
        return false
    }
    override func show() {
        super.show()
        self.textFieldNumbersRoom.becomeFirstResponder()
    }
    
    
}
