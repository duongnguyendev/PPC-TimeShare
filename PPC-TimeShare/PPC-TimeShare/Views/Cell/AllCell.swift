//
//  AllCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class AllCell: NewCell {
    override func fetchResort() {
        APIService.sharedInstance.fetchResortAll { (resorts:[Resort]) in
            self.resorts = resorts
            self.collectionView.reloadData()
        }
    }
}
