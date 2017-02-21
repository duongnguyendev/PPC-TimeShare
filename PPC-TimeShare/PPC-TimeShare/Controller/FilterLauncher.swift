//
//  FilterLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FilterLauncher: NSObject {
    
    let itemSize : CGFloat = 50.0
    override init() {
        super.init()
        setupContent()
    }
    
    let blackView = UIView()
    let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleView : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = "Filter"
        label.textAlignment = .center
        return label
    }()
    
    let countryButton : FilterButton = {
        let button = FilterButton()
        button.value = "Country"
        return button
    }()
    let cityButton : FilterButton = {
        let button = FilterButton()
        button.value = "City"
        return button
    }()
    let typeButton : FilterButton = {
        let button = FilterButton()
        button.value = "Type"
        return button
    }()
    let searchByButton : FilterButton = {
        let button = FilterButton()
        button.value = "Search by"
        return button
    }()
    
    
    let buttonOK : MyButton = {
        let button = MyButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    let buttonCancel : MyButton = {
        let button = MyButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = UIColor.green
        return button
        
    }()
    
    var listOfResortsVC : ListOfResortsVC?
    
    func showFilter(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.contentView.alpha = 1
        }, completion: nil)
        
    }
    func setupContent(){
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
//            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmis)))
            window.addSubview(blackView)
            window.addSubview(contentView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            contentView.alpha = 0
            contentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            window.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: window, attribute: .centerY, multiplier: 1, constant: 0))
            window.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0))
            
            // add view content
            
            contentView.addSubview(titleView)
            contentView.addSubview(buttonCancel)
            contentView.addSubview(buttonOK)
            contentView.addSubview(countryButton)
            contentView.addSubview(cityButton)
            contentView.addSubview(typeButton)
            contentView.addSubview(searchByButton)
            
            //titleView x, y w h
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            titleView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
            titleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
            titleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            // ok, cancel button x y w h
            buttonCancel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
            buttonCancel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            buttonOK.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
            buttonOK.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            contentView.addConstraintWithFormat(format: "H:|[v0][v1]|", views: buttonCancel, buttonOK)
            
            contentView.addConstraint(NSLayoutConstraint(item: buttonCancel, attribute: .width, relatedBy: .equal, toItem: buttonOK, attribute: .width, multiplier: 1, constant: 0))
            
            // item x y w h
            
            countryButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
            contentView.addConstraintWithFormat(format: "V:[v0(\(itemSize))]-1-[v1(\(itemSize))]-1-[v2(\(itemSize))]-1-[v3(\(itemSize))]", views: countryButton, cityButton, typeButton,searchByButton)
            contentView.addConstraintWithFormat(format: "H:|[v0]|", views: countryButton)
            contentView.addConstraintWithFormat(format: "H:|[v0]|", views: cityButton)
            contentView.addConstraintWithFormat(format: "H:|[v0]|", views: typeButton)
            contentView.addConstraintWithFormat(format: "H:|[v0]|", views: searchByButton)
            
            buttonCancel.addTarget(self, action: #selector(handleDissmis), for: .touchUpInside)
            countryButton.addTarget(self, action: #selector(handleCountryButton), for: .touchUpInside)
            cityButton.addTarget(self, action: #selector(handleCityButton), for: .touchUpInside)
            typeButton.addTarget(self, action: #selector(handleTypeButton), for: .touchUpInside)
            searchByButton.addTarget(self, action: #selector(handleSearchByButton), for: .touchUpInside)
            buttonOK.addTarget(self, action: #selector(handleOKButton), for: .touchUpInside)
            
        }
    }
    
    func handleDissmis(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.contentView.alpha = 0
        }) { (Bool) in
            
        }
    }
    
    func handleCountryButton(){
        print("handleCountryButton")
    }
    func handleCityButton(){
        print("handleCityButton")
    }
    func handleTypeButton(){
        print("handleTypeButton")
    }
    func handleSearchByButton(){
        print("handleSearchByButton")
    }
    func handleOKButton(){
        
        self.listOfResortsVC?.filter()
        handleDissmis()
    }
    
    
    
}
