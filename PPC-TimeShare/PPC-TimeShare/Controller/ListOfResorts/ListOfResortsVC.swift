//
//  ListOfResortsVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import CoreLocation

class ListOfResortsVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    let tabViewHeight : CGFloat = 40.0
    let margin : CGFloat = 25.0
    var filterOption : FilterOption? {
        didSet{
            
        }
    }
    var filtered : Bool = false
    
    var selectNew : Bool?{
        didSet{
            if selectNew! {
                buttonNew.isSelected = true
                buttonAll.isSelected = false
            }else{
                buttonNew.isSelected = false
                buttonAll.isSelected = true
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionViewResorts.register(NewCell.self, forCellWithReuseIdentifier: newCellId)
        collectionViewResorts.register(AllCell.self, forCellWithReuseIdentifier: allCellId)
        self.title = LanguageManager.sharedInstance.localizedString(string: "Resorts")
        collectionViewResorts.isPagingEnabled = true
        selectNew = true
    }
    override func setupNavBackButton() {
        super.setupNavBackButton()
        setupFilterButton()
    }
    
    func setupFilterButton(){
        let filterButton = barButton(iconName: "filter_icon")
        filterButton.addTarget(self, action: #selector(handleFilter), for: .touchUpInside)
        let barButtonFilterItem = UIBarButtonItem(customView: filterButton)
        //        self.navigationItem.rightBarButtonItem = barButtonFilterItem
        
        let searchButton = barButton(iconName: "find_resort_icon")
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        let barSearchButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItems = [barButtonFilterItem, barSearchButtonItem]
        
    }
    
    func setupBackGround(){
        let redView : UIView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        redView.backgroundColor = UIColor.appStyleColor()
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        redView.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        
    }
    
    let newCellId = "cellId"
    let allCellId = "allCellId"
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
    
    let buttonNew : TabButton = {
        let button = TabButton()
        let title = LanguageManager.sharedInstance.localizedString(string: "New")
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Light", size: 16)
        button.addTarget(self, action: #selector(handleNewButton), for: .touchUpInside)
        return button
    }()
    let buttonAll : TabButton = {
        let button = TabButton()
        let title = LanguageManager.sharedInstance.localizedString(string: "All")
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Light", size: 16)
        button.addTarget(self, action: #selector(handleAllButton), for: .touchUpInside)
        return button
    }()
    
    let buttonMap : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "map_resort_icon"), for: .normal)
        button.addTarget(self, action: #selector(handleMap), for: .touchUpInside)
        return button
    }()
    
    lazy var filterLauncher : FilterLauncher = {
        let laucher = FilterLauncher()
        laucher.listOfResortsVC = self
        return laucher
    }()
    
    func setupTabView(){
        let lineView = UIView()
        
        tabBarView.addSubview(lineView)
        
        tabBarView.addSubview(buttonNew)
        tabBarView.addSubview(buttonAll)
        tabBarView.addConstraint(NSLayoutConstraint(item: buttonAll, attribute: .width, relatedBy: .equal, toItem: buttonNew, attribute: .width, multiplier: 1, constant: 0))
        
        tabBarView.addConstraintWithFormat(format: "H:|[v0][v1(1)][v2]|", views: buttonNew, lineView, buttonAll)
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
        
        if let flowLayout = collectionViewResorts.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
        }
        
    }
    
    func handleMap(){
        if buttonNew.isSelected {
            let newCell = collectionViewResorts.cellForItem(at: IndexPath(item: 0, section: 0)) as! NewCell
            newCell.mapControl()
        }
        else{
            let allCell = collectionViewResorts.cellForItem(at: IndexPath(item: 1, section: 0)) as! AllCell
            allCell.mapControl()
        }
        
    }
    
    func handleNewButton(){
        
        scrollToItem(item: 0)
        //        selectNew = true
    }
    
    func handleAllButton(){
        scrollToItem(item: 1)
        //        selectNew = false
    }
    
    
    func handleFilter() {
        self.filterLauncher.showFilter()
    }
    //search
    func handleSearch() {
        let searchVC = SearchVC()
        self.pushVC(viewController: searchVC)
    }
    // collection view dalegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier : String
        var cell : NewCell?
        if indexPath.item == 0 {
            identifier = newCellId
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? NewCell
            cell?.lisResortVC = self
        }else{
            
            identifier = allCellId
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AllCell
            cell?.lisResortVC = self
        }
        
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.height - 10 - tabViewHeight - 10 - margin
        return CGSize(width: view.frame.width, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        if index == 0 {
            selectNew = true
        }else{
            selectNew = false
        }
        
        
    }
    func scrollToItem(item: Int){
        
        if item == 0 {
            selectNew = true
        }else{
            selectNew = false
        }
        let indexPath = IndexPath(item: item, section: 0)
        collectionViewResorts.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == 1{
            if self.filterOption != nil, self.filtered == false{
                let allCell = cell as! AllCell
                allCell.filter(option: self.filterOption!)
                filtered = true
            }
            
        }
    }
    
    func filter(country: Country?, province : Province?, type : TypeResort?, searchBy : SearchBy?){
        //filter
        
        let option = FilterOption()
        option.country = country
        option.province = province
        option.type = type
        option.searchBy = searchBy
        self.filterOption = option
        
        if selectNew! {
            scrollToItem(item: 1)
            self.filtered = false
        }
        else {
            let allCell = self.collectionViewResorts.cellForItem(at: IndexPath(item: 1, section: 0)) as! AllCell
            allCell.filter(option: option)
            self.filtered = true
        }
        
    }
    func handleItemResorstSelected(resort : Resort){
        let resortDetailVC : ResortDetailVC = ResortDetailVC()
        resortDetailVC.resort = resort
        pushVC(viewController: resortDetailVC)
    }
    
}
