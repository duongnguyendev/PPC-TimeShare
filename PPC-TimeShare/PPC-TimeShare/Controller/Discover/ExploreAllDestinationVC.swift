//
//  DiscoverVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ExploreAllDestinationVC: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let margin : CGFloat = 25.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Explore All Destination"
        collectionPlacesNearby.register(ResortCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    override func setupView() {
        setupBackGround()
        setupCollectionView()
        
    }
    
    let cellId = "cellId"
    let cellHeight : CGFloat = 50.0
    
    lazy var collectionPlacesNearby : UICollectionView = {
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
        redView.backgroundColor = UIColor.red
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        redView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        
    }
    
    // set up view
    
    func setupCollectionView(){
        view.addSubview(collectionPlacesNearby)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionPlacesNearby)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionPlacesNearby)
        
    }
    
    // collection delegate - datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width
        return CGSize(width: size, height: size - margin - margin)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResortCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC : ResortDetailVC = ResortDetailVC()
        
        pushVC(viewController: detailVC)
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }
}



