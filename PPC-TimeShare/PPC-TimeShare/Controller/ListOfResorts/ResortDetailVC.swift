//
//  ResortDetailVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ResortDetailVC: BaseViewController, SignInDelegate {

    var resort : Resort?{
        didSet{
            title = resort?.name
            imageCollection.listImageUrlString = resort?.images
            labelName.text = resort?.name
            labelPrice.text = resort?.price
            labelAddress.text = resort?.address
            let introHTMLString = "\((resort?.introduceFull)!)\((resort?.service)!)\((resort?.equipment)!)"
            webViewContent.loadHTMLString(introHTMLString, baseURL: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    let imageCollection : CollectionImage = {
        let collection = CollectionImage()
        collection.backgroundColor = UIColor.clear
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
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "BookNow"), for: .normal)
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

    // info view
    let labelName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconAddress : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "adress_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    let iconPrice : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "price_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let labelAddress : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        return label
    }()
    
    let labelPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        return label
    }()
    
    let webViewContent : UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = UIColor.clear
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isOpaque = false
        return webView
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
        tempButtonView.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 20).isActive = true
        tempButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: tempButtonView)
        
        tempButtonView.addSubview(reservationButton)
        
        tempButtonView.addConstraintWithFormat(format: "V:|[v0]|", views: reservationButton)
        tempButtonView.addConstraintWithFormat(format: "H:|[v0]|", views: reservationButton)
        
    }
    func setupInfoView(){
        view.addSubview(labelName)
        view.addSubview(iconAddress)
        view.addSubview(labelAddress)
        view.addSubview(iconPrice)
        view.addSubview(labelPrice)
        view.addSubview(webViewContent)
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelName)
        view.addConstraintWithFormat(format: "H:|-18-[v0(25)][v1]-20-|", views: iconAddress, labelAddress)
        view.addConstraintWithFormat(format: "H:|-18-[v0(25)][v1]-20-|", views: iconPrice, labelPrice)
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webViewContent)
        
        labelName.topAnchor.constraint(equalTo: tempButtonView.bottomAnchor, constant: 10).isActive = true
        view.addConstraintWithFormat(format: "V:[v0(20)][v1(25)][v2(25)][v3]-10-|", views: labelName, iconAddress, iconPrice, webViewContent)
        
        // address label
        labelAddress.centerYAnchor.constraint(equalTo: iconAddress.centerYAnchor, constant: 0).isActive = true
        labelAddress.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // price label
        labelPrice.centerYAnchor.constraint(equalTo: iconPrice.centerYAnchor, constant: 0).isActive = true
        labelPrice.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func handleMap(){
        print("handle Map detail resort")
        let resortMapVC = ResortMapVC()
        resortMapVC.resort = self.resort
        pushVC(viewController: resortMapVC)
    }
    
    func handleReservationButton(){
        
        let currentUserInfo = UserDefaults.standard.value(forKey: "currentUser")
        let userToken = UserDefaults.standard.value(forKey: "token")
        if currentUserInfo != nil {
            
            let user = User(data: currentUserInfo as! Dictionary <String, Any>)
            user.token = userToken as! String?
            let bookVC = BookInAdvanceVC()
            bookVC.resort = self.resort
            bookVC.user = user
            pushVC(viewController: bookVC)
            
        }else{
            let singInVC : SignInVC = SignInVC()
            singInVC.delegate = self
            presentVC(viewController: singInVC)
        }
    }
    func handleBookOnlineButton(){
        let bookVC = BookOnlineVC()
        pushVC(viewController: bookVC)
    }
    func signInWith(user: User) {
        
        let bookVC = BookInAdvanceVC()
        bookVC.resort = self.resort
        bookVC.user = user
        pushVC(viewController: bookVC)
    }
}
