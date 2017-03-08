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
        
        APIService.sharedInstance.requestGetCountries { (countries, errorMes) in
            if errorMes == nil{
                self.listCountry = countries
                self.collectionView.reloadData()
            }
            
        }
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(country: (listCountry?[indexPath.item])!)
        hide()
    }
}







