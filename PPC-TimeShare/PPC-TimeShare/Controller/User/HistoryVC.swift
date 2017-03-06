//
//  HistoryVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HistoryVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let cellId = "cellId"
    lazy var collectionHistory : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        return collectionView

    }()
    override func setupView() {
        collectionHistory.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionHistory)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionHistory)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionHistory)

    }

    
    override func localizeString() {
        title = "Transaction history"
    }
    
    //collection delegate - datasouce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    
    

}
