//
//  AllCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import CoreLocation

class AllCell: NewCell {
    
    var currentPage : Int = 0
    var nextPageUrl : String? = "\(LanguageManager.sharedInstance.localizedString(string: "domain")!)resort/all?page=1"
    override func fetchResort() {
        if nextPageUrl != nil{
            self.activity.startAnimating()
            APIService.sharedInstance.fetchResortAll(pageUrl: nextPageUrl!) { (resorts, errorMes, nextPage) in
                if errorMes != nil {
                    if self.resorts.count == 0{
                        self.noResult()
                    }
                    self.activity.stopAnimating()
                }
                else{
                    self.resorts = self.resorts + resorts!
                    self.collectionView.reloadData()
                    self.addMarkToMap(resorts: resorts!)
                    self.nextPageUrl = nextPage
                    self.activity.stopAnimating()
                    if self.resorts.count == 0{
                        self.noResult()
                    }
                    let firstLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: resorts![0].lat!, longitude: resorts![0].lng!)
                    self.location = firstLocation
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == resorts.count - 1 {
            self.fetchResort()
        }
    }
    
    func filter(option: FilterOption) {
        APIService.sharedInstance.requestFilterResort(option: option) { (resorts, errorMes, nextPage) in
            if errorMes == nil {
                self.resorts = resorts!
                self.collectionView.reloadData()
                self.nextPageUrl = nextPage
                if resorts?.count != 0{
                    let index = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: index, at: .bottom, animated: true)
                    self.haveResult()
                }
                else{
                    self.noResult()
                }
            }
            
        }
    }
}
