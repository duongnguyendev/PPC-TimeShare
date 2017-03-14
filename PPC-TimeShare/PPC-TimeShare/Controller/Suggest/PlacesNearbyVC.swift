//
//  SuggestVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesNearbyVC: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    var resorts : [Resort]?
    let locationManager = CLLocationManager()
    
    func fetchResorts(lat: String, lng: String){
        self.activity.startAnimating()
        APIService.sharedInstance.fetchResortNearBy(lat: lat, lng: lng) { (resorts, errorMes) in
            self.activity.stopAnimating()
            if errorMes == nil{
                self.resorts = resorts
                self.collectionPlacesNearby.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = languageManager.localizedString(string: "PlacesNearby")
        collectionPlacesNearby.register(PlacesNearbyCell.self, forCellWithReuseIdentifier: cellId)
        
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
                locationManager.startUpdatingLocation()
            }
            else{
                let alertController = UIAlertController (title: "",
                                                         message: self.languageManager.localizedString(string: "LocationServices"), preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: self.languageManager.localizedString(string: "Settings"),
                                                   style: .default) { (_) -> Void in
                                                    guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                                                        return
                                                    }
                                                    
                                                    if UIApplication.shared.canOpenURL(settingsUrl) {
                                                        UIApplication.shared.openURL(settingsUrl)
                                                    }
                                                    self.goHome()
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: self.languageManager.localizedString(string: "Cancel"),
                                                 style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    override func setupView() {
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
    
    // set up view
    
    func setupCollectionView(){
        view.addSubview(collectionPlacesNearby)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionPlacesNearby)
        view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: collectionPlacesNearby)
        
    }
    
    // collection delegate - datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resorts?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PlacesNearbyCell
        cell.resort = resorts?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC : ResortDetailVC = ResortDetailVC()
        detailVC.resort = resorts?[indexPath.item]
        pushVC(viewController: detailVC)
    }
    
    override func hideKeyboarTouchupOutSide() {
        
    }
    
    // location manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        let location : CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        let latValue = "\(location.latitude)"
        let lngValue = "\(location.longitude)"
        
        self.fetchResorts(lat: latValue, lng: lngValue)
    }
}
