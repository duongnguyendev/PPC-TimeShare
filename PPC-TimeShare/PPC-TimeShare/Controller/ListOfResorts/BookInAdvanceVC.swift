//
//  BookInAdvance.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BookInAdvanceVC: BaseViewController {

    let margin : CGFloat = 20
    let spaceLine : CGFloat = 1
    var itemHeight : CGFloat?
    
    
    override func viewDidLoad() {
        itemHeight = (view.frame.size.height - 80 - 35 - 40 - 64) / 8
        super.viewDidLoad()
        title = "Book in advance"
    }
    
    let labelName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 13)
        label.text = "Name Resort"
        return label
    }()
    
    let addressIcon : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    let priceIcon : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let labelAddress : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "123 Holywood, Los Angerles, USA"
        label.textColor = UIColor.red
        return label
    }()
    let labelPrice : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "2000 USD"
        label.textColor = UIColor.red
        return label
    }()
    
    let checkInView : BookInfoButton = {
        let v = BookInfoButton()
        v.addTarget(self, action: #selector(handleCheckInButton), for: .touchUpInside)
        v.title = "Check in"
        return v
    }()
    let checkOutView : BookInfoButton = {
        let v = BookInfoButton()
        v.addTarget(self, action: #selector(handleCheckOutButton), for: .touchUpInside)
        v.title = "Check out"
        return v
    }()
    let roomView : BookInfoButton = {
        let v = BookInfoButton()
        v.title = "Room"
        v.addTarget(self, action: #selector(handleRoomButton), for: .touchUpInside)
        return v
    }()
    let TravelersView : BookInfoButton = {
        let v = BookInfoButton()
        v.addTarget(self, action: #selector(handleTravelersButton), for: .touchUpInside)
        v.title = "Travelers"
        return v
    }()
    
    let bookButton : MyButton = {
        let button = MyButton()
        button.setTitle("Book now", for: .normal)
        button.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    override func setupView() {
        addSubView()
        setupResortInfoView()
        setupInfoRequestView()
    }
    func addSubView(){
        view.addSubview(labelName)
        view.addSubview(addressIcon)
        view.addSubview(priceIcon)
        view.addSubview(labelAddress)
        view.addSubview(labelPrice)
        view.addSubview(bookButton)
        view.addSubview(checkInView)
        view.addSubview(checkOutView)
        view.addSubview(roomView)
        view.addSubview(TravelersView)}
    func setupResortInfoView(){
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: labelName)
        labelName.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0(20)]-\(5)-[v1]-\(margin)-|", views: addressIcon, labelAddress)
        addressIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addressIcon.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5).isActive = true
        view.addConstraint(NSLayoutConstraint(item: labelAddress, attribute: .centerY, relatedBy: .equal, toItem: addressIcon, attribute: .centerY, multiplier: 1, constant: 0))
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0(20)]-\(5)-[v1]-\(margin)-|", views: priceIcon, labelPrice)
        priceIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        priceIcon.topAnchor.constraint(equalTo: addressIcon.bottomAnchor, constant: 5).isActive = true
        view.addConstraint(NSLayoutConstraint(item: labelPrice, attribute: .centerY, relatedBy: .equal, toItem: priceIcon, attribute: .centerY, multiplier: 1, constant: 0))
        
        bookButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin).isActive = true
        bookButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        bookButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        bookButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    func setupInfoRequestView(){
        
        
        checkInView.topAnchor.constraint(equalTo: priceIcon.bottomAnchor, constant: 5).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: checkInView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: checkOutView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: roomView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: TravelersView)
        
        view.addConstraintWithFormat(format: "V:[v0(\(itemHeight!))]-\(spaceLine)-[v1(\(itemHeight!))]-\(spaceLine)-[v2(\(itemHeight!))]-\(spaceLine)-[v3(\(itemHeight!))]", views: checkInView, checkOutView, roomView, TravelersView)
    }
    
    //handle button
    
    func handleBook(){
        print("Book in advance")
    }
    
    func handleCheckInButton(){
    print("handleCheckInButton")
    }
    func handleCheckOutButton(){
        print("handleCheckOutButton")
    }
    func handleRoomButton(){
        print("handleRoomButton")
    }
    func handleTravelersButton(){
        print("handleTravelersButton")
    }

}
