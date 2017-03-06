//
//  DiscoverVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ExploreAllDestinationVC: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var resorts : [Resort]?
    func fetchResorts(){
        APIService.sharedInstance.fetchResortRandom { (resorts, errorMes) in
            if errorMes != nil{
            // show mes
            }
            else{
                self.resorts = resorts
                self.collectionResorts.reloadData()
            }
        }
    }
    
    let margin : CGFloat = 25.0
    let temptext = "There was a time when the great Australian dream was a family home on a quarter acre book. Now it seems the aussie dream..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Explore All Destination"
        collectionResorts.register(ResortCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    override func setupView() {
        setupBackGround()
        setupCollectionView()
        fetchResorts()
    }
    
    let cellId = "cellId"
    let cellHeight : CGFloat = 50.0
    
    lazy var collectionResorts : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
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
    
    // set up view
    
    func setupCollectionView(){
        view.addSubview(collectionResorts)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionResorts)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionResorts)
        
    }
    
    // collection delegate - datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resorts?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.width / 16 * 9 + 45 + 45
        
        let size = CGSize(width: view.frame.width - margin - margin - 10, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedRect = NSString(string: (resorts?[indexPath.item].introduce)!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 11)], context: nil)
        
        return CGSize(width: view.frame.size.width, height: height + estimatedRect.height)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResortCell
        cell.resort = resorts?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC : ResortDetailVC = ResortDetailVC()
        detailVC.resort = resorts?[indexPath.item]
        pushVC(viewController: detailVC)
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }
}



