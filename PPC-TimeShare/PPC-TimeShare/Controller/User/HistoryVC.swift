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

        title = languageManager.localizedString(string: "TransactionHistory")
    }
    var userId : NSNumber?
    var books : [BookInfo]?
    
    func fetchBookInfo(){
        self.activity.startAnimating()
        APIService.sharedInstance.requestGetListBook(userId: userId!) { (listBook, errorMes) in
            self.activity.stopAnimating()
            if errorMes != nil{
                let alert = UIAlertController(title: self.languageManager.localizedString(string: "Notifications"),
                                              message: self.languageManager.localizedString(string: "Notifications"),
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }else{
                
                self.books = listBook!
                self.collectionHistory.reloadData()
                
            }
        }
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
    
    let historyLauncher = HistoryLauncher()
    override func setupView() {
        super.setupView()
        self.fetchBookInfo()
        collectionHistory.register(HistoryCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionHistory)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionHistory)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionHistory)
        

    }
    
    //collection delegate - datasouce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HistoryCell
        cell.bookInfo = books?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.historyLauncher.bookInfo = self.books?[indexPath.item]
        self.historyLauncher.show()
    }
    
    
    override func hideKeyboarTouchupOutSide() {
        
    }

}
