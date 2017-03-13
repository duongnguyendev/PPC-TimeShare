//
//  ResortMapVc.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import GoogleMaps

class ResortMapVC: BaseViewController {
    
    var resort : Resort?{
        didSet{
            self.title = resort?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func setupView() {
        
        let location = CLLocationCoordinate2D(latitude: (resort?.lat)!, longitude: (resort?.lng)!)
        
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: 7)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = location
        marker.title = resort?.name
        marker.map = mapView
        
        
    }
    
}
