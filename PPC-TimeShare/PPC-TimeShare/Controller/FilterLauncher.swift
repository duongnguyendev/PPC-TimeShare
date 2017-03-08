//
//  FilterLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FilterLauncher: BaseLauncher, DropDownDelegate {
    
    
    
    let itemSize : CGFloat = 40.0
    
    var currentCountries : Country? = Country(){
        didSet{
            if currentCountries?.countryId != 0{
                dropDownCity.country = currentCountries
            }
            
        }
    }
    var currentProvince : Province = Province()
    var searchBy : SearchBy = SearchBy()
    var type : TypeResort = TypeResort()
    
    override init() {
        super.init()
        
        setupContent()
        setupDropDown()
    }
    let titleView : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.appStyleColor()
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
        
        self.show()
        
    }
    override func setupContent(){
        super.setupContent()
        contentView.clipsToBounds = false
        contentView.heightAnchor.constraint(equalToConstant: 330).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
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
        
        buttonCancel.addTarget(self, action: #selector(hide), for: .touchUpInside)
        countryButton.addTarget(self, action: #selector(handleCountryButton), for: .touchUpInside)
        cityButton.addTarget(self, action: #selector(handleCityButton), for: .touchUpInside)
        typeButton.addTarget(self, action: #selector(handleTypeButton), for: .touchUpInside)
        searchByButton.addTarget(self, action: #selector(handleSearchByButton), for: .touchUpInside)
        buttonOK.addTarget(self, action: #selector(handleOKButton), for: .touchUpInside)
        
        
    }
    
    let dropDownCountry = CountryDropDown()
    let dropDownCity = ProvinceDropDown()
    let dropDownType = TypeDropDown()
    let dropDownSearchBy = SearchByDropDown()
    func setupDropDown(){
        setupDropDownCountry()
        setupDownCity()
        setupDropDownType()
        setupDownSearchBy()
    }
    
    func setupDropDownCountry(){
        contentView.addSubview(dropDownCountry)
        dropDownCountry.delegate = self
        dropDownCountry.leftAnchor.constraint(equalTo: countryButton.leftAnchor, constant: 0).isActive = true
        dropDownCountry.rightAnchor.constraint(equalTo: countryButton.rightAnchor, constant: -50).isActive = true
        dropDownCountry.topAnchor.constraint(equalTo: countryButton.bottomAnchor, constant: 1).isActive = true
        dropDownCountry.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    func setupDownCity(){
        contentView.addSubview(dropDownCity)
        dropDownCity.delegate = self
        dropDownCity.leftAnchor.constraint(equalTo: cityButton.leftAnchor, constant: 0).isActive = true
        dropDownCity.rightAnchor.constraint(equalTo: cityButton.rightAnchor, constant: -50).isActive = true
        dropDownCity.topAnchor.constraint(equalTo: cityButton.bottomAnchor, constant: 1).isActive = true
        dropDownCity.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    func setupDropDownType(){
        contentView.addSubview(dropDownType)
        dropDownType.delegate = self
        dropDownType.leftAnchor.constraint(equalTo: typeButton.leftAnchor, constant: 0).isActive = true
        dropDownType.rightAnchor.constraint(equalTo: typeButton.rightAnchor, constant: -50).isActive = true
        dropDownType.topAnchor.constraint(equalTo: typeButton.bottomAnchor, constant: 1).isActive = true
        dropDownType.heightAnchor.constraint(equalToConstant: 82).isActive = true
    }
    func setupDownSearchBy(){
        contentView.addSubview(dropDownSearchBy)
        dropDownSearchBy.delegate = self
        dropDownSearchBy.leftAnchor.constraint(equalTo: searchByButton.leftAnchor, constant: 0).isActive = true
        dropDownSearchBy.rightAnchor.constraint(equalTo: searchByButton.rightAnchor, constant: -50).isActive = true
        dropDownSearchBy.topAnchor.constraint(equalTo: searchByButton.bottomAnchor, constant: 1).isActive = true
        dropDownSearchBy.heightAnchor.constraint(equalToConstant: 122).isActive = true
    }
    
    func handleCountryButton(){
        if dropDownCountry.isHidden {
            hideAllDropDownView()
            dropDownCountry.show()
        }
        else{
            hideAllDropDownView()
        }
        
    }
    func handleCityButton(){
        if dropDownCity.isHidden {
            
            if currentCountries != nil, currentCountries?.countryId != 0 {
                hideAllDropDownView()
                dropDownCity.show()
            }
        }
        else{
            hideAllDropDownView()
        }
        
    }
    func handleTypeButton(){
        if dropDownType.isHidden {
            hideAllDropDownView()
            dropDownType.show()
        }
        else{
            hideAllDropDownView()
        }
        
    }
    func handleSearchByButton(){
        
        if dropDownSearchBy.isHidden {
            hideAllDropDownView()
            dropDownSearchBy.show()
        }
        else{
            hideAllDropDownView()
        }
        
        
    }
    
    func hideAllDropDownView(){
        dropDownCountry.hide()
        dropDownCity.hide()
        dropDownType.hide()
        dropDownSearchBy.hide()
    }
    func handleOKButton(){
        
        self.listOfResortsVC?.filter(country: currentCountries, province: currentProvince, type: type, searchBy: searchBy)
        hide()
    }
    
    func selected(country : Country){
        
        countryButton.value = country.countryName
        currentCountries = country
        
    }
    func selected(province : Province){
        cityButton.value = province.provinceName
        currentProvince = province
        
    }
    func selected(type : TypeResort){
        typeButton.value = type.typeName
        self.type = type
    }
    func selected(searchBy: SearchBy){
        searchByButton.value = searchBy.searchByName
        self.searchBy = searchBy
    }
    
    
    
}
