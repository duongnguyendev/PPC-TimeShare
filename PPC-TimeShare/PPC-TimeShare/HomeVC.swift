//
//  HomeVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/9/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let navHeight : CGFloat = 60.0
    var minumumItemSize : CGFloat?
    
    let background_1: UIImageView = {
        let image = UIImage(named: "home_bg_1")
        let imageView = UIImageView(image: image);
        return imageView
    }()
    let background_2: UIImageView = {
        let image = UIImage(named: "home_bg_2")
        let imageView = UIImageView(image: image);
        return imageView
    }()

    lazy var navBar : HomeNavBar = {
        let nav = HomeNavBar()
        nav.homeVC = self
        return nav
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        minumumItemSize = view.bounds.width / 3
        addBackground()
        setupNavBar()
        addContent()

    }
    override func viewDidAppear(_ animated: Bool) {
        localize()
    }
    
    func setupNavBar() {
        view.addSubview(navBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: navBar)
        view.addConstraintWithFormat(format: "V:[v0(\(navHeight))]", views: navBar);
        navBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }

    
    func addBackground() {
        
        self.view.addSubview(background_1)
        self.view.addSubview(background_2)
        
        let background1Height = view.frame.height - (minumumItemSize! * 2)
        background_1.heightAnchor.constraint(equalToConstant: background1Height).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: background_1)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: background_2)
        
        self.view.addConstraintWithFormat(format: "V:|-20-[v0][v1]|", views: background_1, background_2)
    }
    
    let sendRequestButton : HomeButtonCustom = {
        
        let button = HomeButtonCustom()
        button.type = HomeButtonType.sendRequest
        button.backgroundColor = UIColor(white: 1, alpha: 0.9)
        button.addTarget(self, action: #selector(handleSendRequestButton), for: .touchUpInside)
        button.iconName = "sent_request_icon"
        return button
    }()
    
    let recruitmentButton : HomeButtonCustom = {
        let button = HomeButtonCustom()
        button.type = HomeButtonType.recruitment
        button.addTarget(self, action: #selector(handleRecruitmentButton), for: .touchUpInside)
        button.title = "Recruitment"
        button.iconName = "recruitment_icon"
        
        return button
    }()
    let introduceButton : HomeButtonCustom = {
        let button = HomeButtonCustom()
        button.type = HomeButtonType.system
        button.addTarget(self, action: #selector(handleIntroduceButton), for: .touchUpInside)
//        button.backgroundColor = UIColor.rgb(red: 208, green: 235, blue: 41)
        button.backgroundColor = UIColor.red
        button.title = "Introduce"

        return button
    }()
    let placesNearbyButton : HomeButtonCustom = {
        let button = HomeButtonCustom()
        button.type = HomeButtonType.normal
        button.addTarget(self, action: #selector(handlePlacesNearbyButton), for: .touchUpInside)
        button.backGroundImage = "button_3"
        button.iconName = "place_nearby_icon"
        button.title = "Places Nearby"

        return button
    }()
    let exploreAllDestinationButton : HomeButtonCustom = {
        let button = HomeButtonCustom()
        button.type = HomeButtonType.normal
        button.addTarget(self, action: #selector(handleExploreAllDestinationButton), for: .touchUpInside)
        button.backGroundImage = "button_2"

        button.iconName = "explore_icon"
        button.title = "Explore All Destination"

        return button
    }()
    let specialOffersButton : HomeButtonCustom = {
        let button = HomeButtonCustom()
        button.type = HomeButtonType.normal
        button.addTarget(self, action: #selector(handleSpecialOffersButton), for: .touchUpInside)
        button.backGroundImage = "button_1"
        button.iconName = "Special_offers_icon"
        button.title = "Special Offers"

        return button
    }()
    let listOfResortsButton : HomeButtonCustom = {
        let button = HomeButtonCustom()
        button.type = HomeButtonType.listResort
        button.title = "RESORTS DIRECTORY"
        button.addTarget(self, action: #selector(handleListOfResortsButton), for: .touchUpInside)
        return button
    }()
        
    func addContent(){
        view.addSubview(sendRequestButton)
        view.addSubview(recruitmentButton)
        view.addSubview(introduceButton)
        view.addSubview(placesNearbyButton)
        view.addSubview(exploreAllDestinationButton)
        view.addSubview(specialOffersButton)
        view.addSubview(listOfResortsButton)
        
        //sendRequestButton contraint
        
//        view.addConstraintWithFormat(format: "V:|-20-|", views: <#T##UIView...##UIView#>)
        sendRequestButton.heightAnchor.constraint(equalToConstant: minumumItemSize! - 30).isActive = true
        sendRequestButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true;
        sendRequestButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true;
        sendRequestButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        //recruitmentButton contraint
        recruitmentButton.heightAnchor.constraint(equalToConstant: minumumItemSize! - 30).isActive = true
        recruitmentButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true;
        recruitmentButton.bottomAnchor.constraint(equalTo: sendRequestButton.topAnchor, constant: 0).isActive = true
        recruitmentButton.widthAnchor.constraint(equalToConstant: minumumItemSize! * 2).isActive = true
        
        //introduceButton contraint
        introduceButton.heightAnchor.constraint(equalToConstant: minumumItemSize! - 30).isActive = true
        introduceButton.widthAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        introduceButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        introduceButton.bottomAnchor.constraint(equalTo: sendRequestButton.topAnchor, constant: 0).isActive = true
        
        //placesNearbyButton contraint
        placesNearbyButton.heightAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        placesNearbyButton.widthAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        placesNearbyButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true;
        placesNearbyButton.bottomAnchor.constraint(equalTo: recruitmentButton.topAnchor, constant: 0).isActive = true
        //exploreAllDestinationButton contraint
        exploreAllDestinationButton.heightAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        exploreAllDestinationButton.widthAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        exploreAllDestinationButton.rightAnchor.constraint(equalTo: placesNearbyButton.leftAnchor, constant: 0).isActive = true;
        exploreAllDestinationButton.bottomAnchor.constraint(equalTo: recruitmentButton.topAnchor, constant: 0).isActive = true
        //specialOffersButton contraint
        specialOffersButton.heightAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        specialOffersButton.widthAnchor.constraint(equalToConstant: minumumItemSize!).isActive = true
        specialOffersButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        specialOffersButton.bottomAnchor.constraint(equalTo: recruitmentButton.topAnchor, constant: 0).isActive = true

        //listOfResortsButton contraint
        listOfResortsButton.heightAnchor.constraint(equalToConstant: view.bounds.size.height - 20 - navHeight - view.bounds.size.width + 40).isActive = true
        listOfResortsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        listOfResortsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        listOfResortsButton.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0).isActive = true
    }
    
    //button handle
    
    func handleSendRequestButton(){
        let sendRequestVC : SendRequestVC = SendRequestVC()
        presentVC(viewContronller: sendRequestVC)
    }
    func handleRecruitmentButton(){
        let recruitmentVC : RecruitmentVC = RecruitmentVC()
        presentVC(viewContronller: recruitmentVC)
    }
    func handleIntroduceButton(){
        let introduceVC : IntroduceVC = IntroduceVC()
        presentVC(viewContronller: introduceVC)
    }
    func handlePlacesNearbyButton(){
        let placesNearbyVC : PlacesNearbyVC = PlacesNearbyVC()
        presentVC(viewContronller: placesNearbyVC)
        
    }
    func handleExploreAllDestinationButton(){
        let exploreAllDestinationVC : ExploreAllDestinationVC = ExploreAllDestinationVC()
        presentVC(viewContronller: exploreAllDestinationVC)
        
    }
    func handleSpecialOffersButton(){
        let specialOffersVC : SpecialOffersVC = SpecialOffersVC()
        presentVC(viewContronller: specialOffersVC)
        
    }
    func handleListOfResortsButton(){
        let listOfResortsVC : ListOfResortsVC = ListOfResortsVC()
        presentVC(viewContronller: listOfResortsVC)
        
    }
    
    // nav event
    func navUserClick(){
        
        let currentUserInfo = UserDefaults.standard.value(forKey: "currentUser")
        let userToken = UserDefaults.standard.value(forKey: "token")
        if currentUserInfo != nil {
            
            let user = User(data: currentUserInfo as! Dictionary <String, Any>)
            user.token = userToken as! String?
            let userProfileVC = UserProfileVC()
            userProfileVC.user = user
            presentVC(viewContronller: userProfileVC)
            
        }else{
            let singInVC : SignInVC = SignInVC()
            presentVC(viewContronller: singInVC)
        }
        
        
    }
    
    func navSettingsClick(){
        let settingVC : SettingsVC = SettingsVC()
        presentVC(viewContronller: settingVC)

    
    }
    
    func presentVC(viewContronller : BaseViewController) {
        viewContronller.presented = true
        let navVC : UINavigationController = UINavigationController(rootViewController: viewContronller)
        self.present(navVC, animated: true) { 
            //do something late
        }
    }
    
    func localize() {
        sendRequestButton.title = LanguageManager.sharedInstance.localizedString(string: "SendRequest")
    }
}
