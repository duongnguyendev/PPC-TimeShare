//
//  FeedCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import GoogleMaps

class NewCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var lisResortVC : ListOfResortsVC?
    
    let margin : CGFloat = 25.0
    
    var resorts: [Resort]?
    func fetchResort(){
        APIService.sharedInstance.fetchResortNew { (resorts : [Resort]?, errorMessage) in
            
            if errorMessage == nil{
                self.resorts = resorts
                self.collectionView.reloadData()
                self.addMarkToMap()
            }  
        }
    }
    
    override func setupView() {
        fetchResort()
        backgroundColor = UIColor.clear
        addSubview(collectionView)
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        mapView = mymapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        mapView?.isHidden = true
        
        addSubview(mapView!)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(ResortCell.self, forCellWithReuseIdentifier: cellId)
//        
        addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: mapView!)
        addConstraintWithFormat(format: "V:|[v0]|", views: mapView!)
        
        

        
    }
  
    let cellId = "cellId"
    var mapView : GMSMapView?
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resorts?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResortCell
        
        cell.resort = resorts?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.width / 16 * 9 + 45 + 45
        
        let size = CGSize(width: frame.width - margin - margin - 10, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let text = resorts?[indexPath.item].introduce
        let estimatedRect = NSString(string: text!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 11)], context: nil)
        
        return CGSize(width: frame.size.width, height: height + estimatedRect.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lisResortVC?.handleItemResorstSelected(resort: (self.resorts?[indexPath.item])!)
    }
    
    
    func mapControl(){
        if (mapView?.isHidden)! {
            mapView?.isHidden = false
        }
        else{
            mapView?.isHidden = true
        }
    }
    func addMarkToMap(){
        
        for resort in resorts!{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: resort.lat!, longitude: resort.lng!)
            marker.title = resort.name
//            marker.snippet = "Australia"
            marker.map = mapView
        }
    }
}
