//
//  IntroduceVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
enum EnumIntroduceName{
    case AboutUs
    case WhatISTimeshare
    case FAQs
    case PPCTimesharebusiness
    case Benefits
    case ExchangeProgram
}

class IntroduceVC: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let itemCollectionHeigh : CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Introduction"
        collectionView.register(IntroduceCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(HearderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId);
        setupCollectionView()
    }
    let introductions : [EnumIntroduceName] = {
        let aboutUs = EnumIntroduceName.AboutUs
        let whatIs = EnumIntroduceName.WhatISTimeshare
        let faqs = EnumIntroduceName.FAQs
        let business = EnumIntroduceName.PPCTimesharebusiness
        let benifits = EnumIntroduceName.Benefits
        let exchangeProgram = EnumIntroduceName.ExchangeProgram
        return [aboutUs,whatIs,faqs,business,benifits,exchangeProgram]
    }()
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
    }

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId = "cellId"
    let headerId = "headerId"
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IntroduceCell
        var intro : EnumIntroduceName?
        if indexPath.section == 1 {
            intro = introductions[indexPath.row + 3]
        }else{
            intro = introductions[indexPath.row]
        }
        cell.item = intro
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: itemCollectionHeigh)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !((indexPath.section == 0) && (indexPath.row == 2))  {
            var intro : EnumIntroduceName?
            if indexPath.section == 1 {
                intro = introductions[indexPath.row + 3]
            }else{
                intro = introductions[indexPath.row]
            }
            let detailVC = IntroductionDetail()
            detailVC.introduce = intro
            pushVC(viewController: detailVC)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headerView : HearderView? = nil
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HearderView
            if indexPath.section == 1 {
                headerView?.labelHeader.text = "Introduction"
            }else{
                headerView?.labelHeader.text = "PPC TimeShare"
            }
            
            return headerView!
        }
        return headerView!
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }
}
