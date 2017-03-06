//
//  CollectionImage.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class CollectionImage: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var listImageUrlString : [String]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    let cellId = "cellId"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImageUrlString?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        cell.imageUrlString = listImageUrlString?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.size.width / 16 * 9
        return CGSize(width: frame.size.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class ImageCell: BaseCell {
    
    var imageUrlString : String?{
        didSet{
            self.imageView.loadImageUsingUrlString(urlString: imageUrlString!)
        }
    }
    override func setupView() {
        addSubview(imageView)
        addConstraintWithFormat(format: "V:|[v0]|", views: imageView)
        addConstraintWithFormat(format: "H:|[v0]|", views: imageView)
    }
    
    let imageView : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "no_image_icon"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
}
