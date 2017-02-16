//
//  ListOfResortsVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ListOfResortsVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let tabViewHeight : CGFloat = 40.0
    let margin : CGFloat = 25.0
    var selectNew = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewResorts.register(ResortCell.self, forCellWithReuseIdentifier: cellId)
        self.title = "Resorts"
        buttonNew.isSelected = true
    }
    override func setupNavBackButton() {
        super.setupNavBackButton()
        setupFilterButton()
    }
    
    func setupBackGround(){
        let redView : UIView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        redView.backgroundColor = UIColor.red
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        redView.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        
    }
    
    let cellId = "cellId"
    lazy var collectionViewResorts : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    let tabBarView : UIView = {
        let tabView = UIView()
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.backgroundColor = UIColor.white
        return tabView
    }()
    
    let buttonNew : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitleColor(UIColor.yellow, for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("New", for: .normal)
        button.addTarget(self, action: #selector(handleNewButton), for: .touchUpInside)
        return button
    }()
    let buttonAll : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitleColor(UIColor.yellow, for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("All", for: .normal)
        button.addTarget(self, action: #selector(handleAllButton), for: .touchUpInside)

        return button
    }()
    
    let buttonMap : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(handleMap), for: .touchUpInside)
        return button
    }()

    
    func setupTabView(){
        let lineView = UIView()
        
        tabBarView.addSubview(lineView)

        tabBarView.addSubview(buttonNew)
        tabBarView.addSubview(buttonAll)
        tabBarView.addConstraint(NSLayoutConstraint(item: buttonAll, attribute: .width, relatedBy: .equal, toItem: buttonNew, attribute: .width, multiplier: 1, constant: 0))
        
        tabBarView.addConstraintWithFormat(format: "H:|[v0]-[v1(1)]-[v2]|", views: buttonNew, lineView, buttonAll)
        tabBarView.addConstraintWithFormat(format: "V:|-10-[v0]-10-|", views: lineView)
        lineView.backgroundColor = UIColor.red
        
        buttonNew.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 0).isActive = true
        buttonNew.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: 0).isActive = true
        
        buttonAll.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 0).isActive = true
        buttonAll.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: 0).isActive = true
        
        
    }
    override func setupView() {
        setupBackGround()
        view.addSubview(tabBarView)
        view.addSubview(collectionViewResorts)
        view.addSubview(buttonMap)
        
        view.addConstraintWithFormat(format: "V:|-10-[v0(\(tabViewHeight))]-\(margin)-[v1]|", views: tabBarView, collectionViewResorts)
        
        tabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        tabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0 - margin).isActive = true
        setupTabView()
        
        collectionViewResorts.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionViewResorts.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        buttonMap.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonMap.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonMap.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonMap.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
    }
    
    func handleMap(){
        let mapVC : MapListResortVC = MapListResortVC()
        pushVC(viewController: mapVC)
    }
    
    func handleNewButton(){
//        if buttonNew.isSelected {
//            
//        }else{
//        
//        }
        buttonNew.isSelected = true
        buttonAll.isSelected = false
    }
    
    func handleAllButton(){
//        if buttonAll.isSelected {
//            
//        }else{
//            
//        }
        buttonAll.isSelected = true
        buttonNew.isSelected = false
    }
    
    override func handleFilter() {
        print("filter")
    }
    
    
    // collection view dalegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResortCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width
        return CGSize(width: size, height: size - margin)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resortDetailVC : ResortDetailVC = ResortDetailVC()
        pushVC(viewController: resortDetailVC)
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }
    
}
