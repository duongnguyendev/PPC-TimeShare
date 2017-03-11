//
//  FAQsVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FAQsVC: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var faqs : [Dictionary<String, Any>]?
    
    lazy var collectionFAQs : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func fetchFAQs(){
        self.activity.startAnimating()
        APIService.sharedInstance.getFAQs { (faqs, errorMes) in
            self.activity.stopAnimating()
            if errorMes == nil{
                self.faqs = faqs
                self.collectionFAQs.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAQs"
        collectionFAQs.register(FAQsCell.self, forCellWithReuseIdentifier: cellId)

    }
    override func setupView() {
        fetchFAQs()
        view.addSubview(collectionFAQs)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionFAQs)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionFAQs)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faqs?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FAQsCell
        let question = faqs?[indexPath.item]["cauhoi"] as! String
        cell.htmlContent = question
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let question = faqs?[indexPath.item]["cauhoi"] as! String
        let htmlString = question
        
        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: htmlString).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.init(name: "Times New Roman", size: 15) as Any], context: nil)
        
        return CGSize(width: view.frame.size.width, height: estimatedRect.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let question = faqs?[indexPath.item]["cauhoi"] as! String
        let asked  = faqs?[indexPath.item]["cautraloi"] as! String
        let detailVC = FAQsDetailVC()
        detailVC.htmlContent = question + asked
        self.pushVC(viewController: detailVC)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }

}
