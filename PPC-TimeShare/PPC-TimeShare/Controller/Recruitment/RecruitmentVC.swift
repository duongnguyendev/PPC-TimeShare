//
//  RecruitmentVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class RecruitmentVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var recruitments : [Recruitment]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = languageManager.localizedString(string: "Recruitment")
        collectionRecruitment.register(RecruitmentCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchRecruitments(){
        self.activity.startAnimating()
        APIService.sharedInstance.getRecruitments { (recruitments, errorMes) in
            self.activity.stopAnimating()
            if errorMes != nil{
                //show mes
            }else{
                self.recruitments = recruitments
                self.collectionRecruitment.reloadData()
            }
            
        }
    }
    
    override func setupView() {
        super.setupView()
        fetchRecruitments()
        setupCollectionView()
        
    }
    
    let cellId = "cellId"
    let cellHeight : CGFloat = 50.0
    
    lazy var collectionRecruitment : UICollectionView = {
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
        view.addSubview(collectionRecruitment)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionRecruitment)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionRecruitment)
        
    }
    
    // collection delegate - datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recruitments?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: cellHeight)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecruitmentCell
        cell.recruitment = recruitments?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC : RecruitmentDetailVC = RecruitmentDetailVC()
        detailVC.recruitment = recruitments?[indexPath.item]
        pushVC(viewController: detailVC)
    }
    override func hideKeyboarTouchupOutSide() {
        
    }
    
}
