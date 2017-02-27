//
//  GenderDropDown.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Gender :  NSObject{
    var genderId : Int
    var genderValue : String?
    init(genderId : Int, genderValue : String) {
        self.genderId = genderId
        self.genderValue = genderValue
    }
    init(genderId : Int) {
        self.genderId = genderId
        self.genderValue = ((genderId == 1) ? "Male" : "Female")
    }
}

class GenderDropDown: DropDownView {
    
    let listGender : [Gender] = {
        let male = Gender(genderId: 0, genderValue: "Male")
        let female = Gender(genderId: 1, genderValue: "Female")
        return [male, female]
    }()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGender.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listGender[indexPath.item].genderValue
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(gender: listGender[indexPath.row])
        hide()
    }

}
