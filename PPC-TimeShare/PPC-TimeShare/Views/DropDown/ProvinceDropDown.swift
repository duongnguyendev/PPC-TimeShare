//
//  ProvinceDropDown.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ProvinceDropDown: DropDownView {
    var listProvince: [Province]?
    
    var country : Country? {
        didSet{
            fetchItems()
        }
    }
    
    
    override func fetchItems() {
        APIService.sharedInstance.requestGetProvinces(country: country!) { (provinces, errorMes) in
            if errorMes == nil{
                self.listProvince = provinces
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProvince?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DropDownCell
        cell.labelString.text = listProvince?[indexPath.item].provinceName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 40)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(province: (listProvince?[indexPath.item])!)
        hide()
    }
}


