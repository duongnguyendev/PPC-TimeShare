//
//  ListVoucherLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ListVoucherLauncher: BaseLauncher, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate : InputLauncherDelegate?
    let cellId = "cellId"
    lazy var collectionVoucher : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        return cv
    }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.appStyleColor()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Vouchers"
        return label
    }()
    
    var vouchers : [Voucher]?
    func fretchVoucher(){
        let userInfo = UserDefaults.standard.value(forKey: "currentUser")
        let user = User(data: userInfo as! Dictionary <String, Any>)
        APIService.sharedInstance.requestGetListVoucher(userId: user.userId as! Int) { (vouchers, errorMes) in
            if errorMes != nil{
                // show mes
            }else{
                if vouchers?.count == 0{
                    self.noResult()
                }else{
                    self.vouchers = vouchers
                    self.collectionVoucher.reloadData()
                }
            }
        }
    }
    
    override func setupContent() {
        fretchVoucher()
        super.setupContent()
        touchUpOutSize()
        collectionVoucher.register(VoucherCell.self, forCellWithReuseIdentifier: cellId)
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionVoucher)
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: titleLabel)
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: collectionVoucher)
        contentView.addConstraintWithFormat(format: "V:|[v0(40)][v1]|", views:titleLabel, collectionVoucher)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vouchers?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VoucherCell
        cell.voucher = vouchers?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.getVoucher!(voucher: (self.vouchers?[indexPath.item])!)
        self.hide()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func noResult(){
        
        let imageView = UIImageView(image: UIImage(named: "noresult_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
}
class VoucherCell : BaseCell {
    
    var voucher : Voucher?{
        didSet{
            self.labelCost.text = voucher?.cost
            self.labelName.text = voucher?.name
        }
    }
    
    let labelName = UILabel()
    let labelCost = UILabel()
    let iconCost : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "price_icon"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override func setupView() {
        super.setupView()
        addSubview(labelCost)
        addSubview(labelName)
        addSubview(iconCost)
        labelName.font = UIFont(name: "Roboto-Regular", size: 16)
        labelCost.font = UIFont(name: "Roboto-Light", size: 14)
        backgroundColor = UIColor.white
        
        labelName.text = "Voucher 1"
        labelCost.text = "$100"
        addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: labelName)
        addConstraintWithFormat(format: "V:|-10-[v0(20)][v1(20)]", views: labelName, iconCost)
        addConstraintWithFormat(format: "H:|-10-[v0(20)]-10-[v1]|", views: iconCost, labelCost)
        labelCost.centerYAnchor.constraint(equalTo: iconCost.centerYAnchor, constant: 0).isActive = true
    }
}

