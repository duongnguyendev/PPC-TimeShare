//
//  DropDownView.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

@objc  protocol DropDownDelegate{
    
    @objc optional func selected(type: TypeResort)
    @objc optional func selected(gender: Gender)
    @objc optional func selected(country: Country)
    @objc optional func selected(province : Province)
    @objc optional func selected(searchBy: SearchBy)
    @objc optional func selected(language: Language)
    
}

class DropDownView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func fetchItems() {
        
    }
    
    var collectionViewHeightContraint : NSLayoutConstraint?
    var delegate : DropDownDelegate?
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.isHidden = true
        collectionView.layer.cornerRadius = 5
        collectionView.layer.masksToBounds = true
        addSubview(collectionView)
        collectionView.register(DropDownCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 1).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId = "cellId"
    
    func show(){
        self.isHidden = false
    }
    
    func hide(){
        self.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hide()
    }
}

class DropDownCell: BaseCell {
    
    let labelString : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Light", size: 16)
        return label
    }()
    
    override func setupView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        backgroundColor = UIColor.rgb(red: 238, green: 238, blue: 238)
        addSubview(labelString)
        labelString.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        labelString.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        labelString.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        labelString.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
    }
}

class TypeDropDown: DropDownView {
    
    var listType : [TypeResort] = [TypeResort]()
    
    override func fetchItems() {
        APIService.sharedInstance.requestGetTypesResort { (types, errorMes) in
            if errorMes == nil{
                self.listType = types!
                self.collectionView.reloadData()
            }
        }
    }
    
    override func setupView() {
        super.setupView()
        self.fetchItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listType.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listType[indexPath.item].typeName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(type: (listType[indexPath.item]))
        hide()
    }
    
}

class SearchByDropDown: DropDownView {
    
    let listSearchBy : [SearchBy] = {
        let all = SearchBy(searchById: 0, searchByName: "All")
        let new = SearchBy(searchById: 1, searchByName: "New")
        let sale = SearchBy(searchById: 2, searchByName: "Sale")
        
        return [all, new, sale]
    }()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSearchBy.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listSearchBy[indexPath.item].searchByName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        filterLauncher?.selectedType(type: listSearchBy[indexPath.item])
        self.delegate?.selected!(searchBy: listSearchBy[indexPath.item])
        hide()
    }
    
}












































