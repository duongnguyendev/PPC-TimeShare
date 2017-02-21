//
//  ResortDetailVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ResortDetailVC: BaseViewController {

    var resort : Resort?{
        didSet{
            title = resort?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    let imageCollection : CollectionImage = {
        let collection = CollectionImage()
        
        return collection
    }()
    
    let buttonMap : MyButton = {
        let button = MyButton()
        button.setBackgroundImage(UIImage(named: "map_resort_icon"), for: .normal)
        button.addTarget(self, action: #selector(handleMap), for: .touchUpInside)
        return button
    }()
    
    let tempButtonView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    
    let reservationButton : MyButton = {
        let button = MyButton()
        button.setTitle("Reservation", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(handleReservationButton), for: .touchUpInside)
        return button
    }()
    let bookOnlineButton : MyButton = {
        let button = MyButton()
        button.setTitle("Book Online", for: .normal)
        button.addTarget(self, action: #selector(handleBookOnlineButton), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    let infoView : ResortInfoView = {
        let view = ResortInfoView()
        return view
    }()
    
    override func setupView() {
        setupScrollView()
        setupMapButton()
        setupButton()
        setupInfoView()
    }
    
    func setupScrollView(){
        
        view.addSubview(imageCollection)
        let imageHeight = view.frame.width / 16 * 9;
        imageCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        imageCollection.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
    }
    
    func setupMapButton(){
        view.addSubview(buttonMap)
        
        buttonMap.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonMap.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonMap.rightAnchor.constraint(equalTo: imageCollection.rightAnchor, constant: -10).isActive = true
        buttonMap.bottomAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: -10).isActive = true
        
    }
    
    func setupButton(){
        view.addSubview(tempButtonView)
        tempButtonView.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 0).isActive = true
        tempButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: tempButtonView)
        
        tempButtonView.addSubview(reservationButton)
        tempButtonView.addSubview(bookOnlineButton)
        
        tempButtonView.addConstraintWithFormat(format: "V:|[v0]|", views: reservationButton)
        tempButtonView.addConstraintWithFormat(format: "V:|[v0]|", views: bookOnlineButton)
        tempButtonView.addConstraint(NSLayoutConstraint(item: reservationButton, attribute: .width, relatedBy: .equal, toItem: bookOnlineButton, attribute: .width, multiplier: 1, constant: 0))
        tempButtonView.addConstraintWithFormat(format: "H:|[v0][v1]|", views: reservationButton, bookOnlineButton)
        
    }
    func setupInfoView(){
        view.addSubview(infoView)
        infoView.topAnchor.constraint(equalTo: tempButtonView.bottomAnchor, constant: 0).isActive = true
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func handleMap(){
        print("handle Map detail resort")
    }
    
    func handleReservationButton(){
        let bookVC = BookInAdvanceVC()
        pushVC(viewController: bookVC)
    }
    func handleBookOnlineButton(){
        let bookVC = BookOnlineVC()
        pushVC(viewController: bookVC)
    }
}
