//
//  CountryDropDown.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class CountryDropDown: DropDownView {
    
    var listCountry: [Country]?
    
    override func setupView() {
        super.setupView()
        fetchItems()
    }
    
    override func fetchItems() {
        let country1 = Country(countryId: "1", countryName: "Country 1")
        let country2 = Country(countryId: "2", countryName: "Country 2")
        let country3 = Country(countryId: "3", countryName: "Country 3")
        let country4 = Country(countryId: "4", countryName: "Country 4")
        let country5 = Country(countryId: "5", countryName: "Country 5")
        let country6 = Country(countryId: "6", countryName: "Country 6")
        let country7 = Country(countryId: "7", countryName: "Country 7")
        let country8 = Country(countryId: "8", countryName: "Country 8")
        let country9 = Country(countryId: "9", countryName: "Country 9")
        let country10 = Country(countryId: "10", countryName: "Country 10")
        listCountry = [country1, country2, country3, country4, country5, country6, country7, country8,country9, country10]
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCountry?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listCountry?[indexPath.item].countryName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(country: (listCountry?[indexPath.item])!)
        hide()
    }
}







