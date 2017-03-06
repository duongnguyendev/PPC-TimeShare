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
}

class InputTravelersLauncher: BaseLauncher, UITextFieldDelegate {
    
    var delegate : InputLauncherDelegate?
    
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
        tF.text = "0"
        tF.borderStyle = .roundedRect
        return tF
    }()
    
    lazy var textFieldNumberChilds : UITextField = {
        let tF = UITextField()
        tF.textAlignment = .right
        tF.translatesAutoresizingMaskIntoConstraints = false
        tF.borderStyle = .roundedRect
        tF.text = "0"
        tF.delegate = self
        return tF
    }()
    let buttonOk : MyButton = {
        let button = MyButton()
        button.setTitle("Ok", for: .normal)
        button.backgroundColor = UIColor.yellow
        return button
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
        contentView.addSubview(buttonOk)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: labelTitle)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: buttonOk)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0(50)]-5-[v1]-10-|", views:labelAdults,  textFieldNumberAdults)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0(50)]-5-[v1]-10-|", views:labelChilds, textFieldNumberChilds)
        
        contentView.addConstraintWithFormat(format: "V:|[v0(40)]-10-[v1(30)]-10-[v2(30)]-10-[v3(40)]-10-|", views: labelTitle, textFieldNumberAdults, textFieldNumberChilds, buttonOk)
        
        labelAdults.centerYAnchor.constraint(equalTo: textFieldNumberAdults.centerYAnchor, constant: 0).isActive = true
        labelChilds.centerYAnchor.constraint(equalTo: textFieldNumberChilds.centerYAnchor, constant: 0).isActive = true
        
        buttonOk.addTarget(self, action: #selector(handleButtonOk), for: .touchUpInside)
    }
    
    func handleButtonOk(){
        
        if self.delegate != nil {
            if let numberAdults = Int(textFieldNumberAdults.text!), let numberChilds = Int(textFieldNumberChilds.text!){
                self.delegate?.getNumberTravelers!(adults: numberAdults, childs: numberChilds)
                self.hide()
            }else{
                self.hide()
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (Int(string) != nil){
            return true
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
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.appStyleColor()
        label.text = "Rooms"
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
        tF.text = "0"
        tF.borderStyle = .roundedRect
        return tF
    }()
    
    let buttonOk : MyButton = {
        let button = MyButton()
        button.setTitle("Ok", for: .normal)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    override func setupContent() {
        super.setupContent()
        
        
        //contentView size
        contentView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.blackView.centerYAnchor, constant: -50).isActive = true
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(textFieldNumbersRoom)
        contentView.addSubview(buttonOk)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: labelTitle)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: buttonOk)
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views:textFieldNumbersRoom)
        
        contentView.addConstraintWithFormat(format: "V:|[v0(40)]-10-[v1(30)]-10-[v2(40)]-10-|", views: labelTitle, textFieldNumbersRoom, buttonOk)

        buttonOk.addTarget(self, action: #selector(handleButtonOk), for: .touchUpInside)
    }
    
    func handleButtonOk(){
        
        if self.delegate != nil , textFieldNumbersRoom.text != ""{
            self.delegate?.getNumberRooms!(rooms: Int(textFieldNumbersRoom.text!)!)
        }
        self.hide()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (Int(string) != nil) || string == ""{
            return true
        }
        return false
    }
    override func show() {
        super.show()
        self.textFieldNumbersRoom.becomeFirstResponder()
    }
    
    
}
