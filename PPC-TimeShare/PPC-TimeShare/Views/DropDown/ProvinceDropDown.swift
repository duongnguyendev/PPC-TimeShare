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
        let city1 = Province(provinceId: "1", provinceName: "city 1")
        let city2 = Province(provinceId: "2", provinceName: "city 2")
        let city3 = Province(provinceId: "3", provinceName: "city 3")
        let city4 = Province(provinceId: "4", provinceName: "city 4")
        let city5 = Province(provinceId: "5", provinceName: "city 5")
        let city6 = Province(provinceId: "6", provinceName: "city 6")
        let city7 = Province(provinceId: "7", provinceName: "city 7")
        let city8 = Province(provinceId: "8", provinceName: "city 8")
        let city9 = Province(provinceId: "9", provinceName: "city 9")
        let city10 = Province(provinceId: "10", provinceName: "city 10")
        listProvince = [city1, city2, city3, city4, city5, city6, city7, city8,city9 , city10]
        collectionView.reloadData()
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
        return CGSize(width: self.frame.size.width, height: 30)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(province: (listProvince?[indexPath.item])!)
        hide()
    }
}


