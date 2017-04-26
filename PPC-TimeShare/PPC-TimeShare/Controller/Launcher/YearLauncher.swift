//
//  YearLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 4/26/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class YearLauncher: BaseLauncher, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : InputLauncherDelegate?
    let pickerView = UIPickerView()
    var selectedYear = Date().year
    var starYear = Date().year
    
    override func setupContent() {
        super.setupContent()
        contentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        contentView.addSubview(pickerView)
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: pickerView)
        pickerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: buttonOK.topAnchor, constant: 0).isActive = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(starYear + row)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = starYear + row
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    override func handleOKButton() {
        if self.delegate != nil{
            self.delegate?.selected!(year: selectedYear)
            self.hide()
        }
    }
    

}
