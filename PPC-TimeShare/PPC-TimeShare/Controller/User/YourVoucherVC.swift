//
//  YourVoucherVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class YourVoucherVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var userId : NSNumber?
    let cellId = "cellId"
    var vouchers : [Voucher]?
    
    func fretchVoucher(){
        self.activity.startAnimating()
        let userInfo = UserDefaults.standard.value(forKey: "currentUser")
        let user = User(data: userInfo as! Dictionary <String, Any>)
        APIService.sharedInstance.requestGetListVoucher(userId: user.userId as! Int) { (vouchers, errorMes) in
            self.activity.stopAnimating()
            if errorMes != nil{
                // show mes
            }else{
                if vouchers?.count == 0{
                }else{
                    self.vouchers = vouchers
                    self.collectionVoucher.reloadData()
                }
            }
        }
    }
    
    lazy var collectionVoucher : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVoucher.register(VoucherCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func setupView() {
        fretchVoucher()
        view.addSubview(collectionVoucher)
        
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionVoucher)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionVoucher)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vouchers?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VoucherCell
        cell.voucher = vouchers?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
