//
//  SearchVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/8/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SearchVC: BaseViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var searchViewController : UISearchController!
    lazy var colletionSearchResult: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchViewController = UISearchController(searchResultsController: nil)
        self.searchViewController.searchResultsUpdater = self
        self.searchViewController.delegate = self
        self.searchViewController.searchBar.delegate = self
        self.searchViewController.hidesNavigationBarDuringPresentation = false
        self.searchViewController.dimsBackgroundDuringPresentation = true
        self.searchViewController.searchBar.tintColor = UIColor.white
        self.navigationItem.titleView = searchViewController.searchBar
        self.definesPresentationContext = true
    }
    
    override func setupView() {
        colletionSearchResult.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(colletionSearchResult)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: colletionSearchResult)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: colletionSearchResult)
    }
    //search bar
    func updateSearchResults(for searchController: UISearchController) {

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print(searchBar.text as Any)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == " " {
            print(searchBar.text!)
        }
        return true
    }

    // collection
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
