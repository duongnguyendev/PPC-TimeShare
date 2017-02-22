//
//  DropDownView.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class DropDownView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func fetchItems() {
        
    }
    var filterLauncher : FilterLauncher?
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.gray
        self.isHidden = true
        
        addSubview(collectionView)
        collectionView.register(DropDownCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
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
        return CGSize(width: self.frame.size.width, height: 30)
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
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(labelString)
        labelString.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        labelString.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        labelString.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        labelString.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
    }
}

class TypeDropDown: DropDownView {
    
    let listType = ["Home", "Resort"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listType.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listType[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterLauncher?.selectedType(type: listType[indexPath.item])
        hide()
    }
    
}

class SearchByDropDown: DropDownView {
    
    let listSearchBy = ["All", "New"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSearchBy.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listSearchBy[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterLauncher?.selectedType(type: listSearchBy[indexPath.item])
        hide()
    }
    
}












































