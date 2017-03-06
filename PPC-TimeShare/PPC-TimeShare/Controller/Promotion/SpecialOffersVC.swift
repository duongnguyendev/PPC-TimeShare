//
//  PromotionVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SpecialOffersVC: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var offers : [Offer]?
    
    func fetchOffers(){
        APIService.sharedInstance.requestGetOffers { (offers, errorMes) in
            if errorMes != nil{
                //show mes
            }else{
                self.offers = offers
                self.collectionOffers.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Special Offers"
        collectionOffers.register(SpecialOffersCell.self, forCellWithReuseIdentifier: cellId)
        fetchOffers()

    }
    override func setupView() {
        setupBackGround()
        setupCollectionView()
        
    }
    
    let cellId = "cellId"
    
    lazy var collectionOffers : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // set up view
    
    func setupCollectionView(){
        view.addSubview(collectionOffers)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionOffers)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionOffers)
        
    }
    
    func setupBackGround(){
        let redView : UIView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        redView.backgroundColor = UIColor.appStyleColor()
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        redView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        
    }
    
    // collection delegate - datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let imageheight = (view.frame.width) / 16 * 9
        
        let size = CGSize(width: view.frame.width - 50 - 20, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedRect = NSString(string: (offers?[indexPath.item].title)!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 13)], context: nil)
        
        return CGSize(width: view.frame.size.width, height: imageheight + estimatedRect.height + 45)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SpecialOffersCell
        cell.offer = offers?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC : SpecialOffersDetailVC = SpecialOffersDetailVC()
        pushVC(viewController: detailVC)
        detailVC.offer = offers?[indexPath.item]
    }
    override func hideKeyboarTouchupOutSide() {
        
    }
}
