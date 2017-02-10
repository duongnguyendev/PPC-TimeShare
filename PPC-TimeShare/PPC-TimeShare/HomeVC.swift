//
//  HomeVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/9/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let navHeight : CGFloat = 55.0
    
    let background: UIImageView = {
        let image = UIImage(named: "home_background")
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

//        self.title = "Home"
        addBackground()
        setupNavBar()
        addContent()
    }
    
    func setupNavBar() {
        view.addSubview(navBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: navBar)
        view.addConstraintWithFormat(format: "V:[v0(\(navHeight))]", views: navBar);
        navBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }

    
    func addBackground() {
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "home_background")!)
        self.view.addSubview(background)
        
        self.view.addConstraintWithFormat(format: "H:|[v0]|", views: background)
        self.view.addConstraintWithFormat(format: "V:|-20-[v0]|", views: background);
    }
    
    let sendRequestButton : UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(handleSendRequestButton), for: .touchUpInside)
        return button
    }()
    
    let recruitmentButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRecruitmentButton), for: .touchUpInside)

        return button
    }()
    let introduceButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleIntroduceButton), for: .touchUpInside)
        button.backgroundColor = UIColor.blue

        return button
    }()
    let suggestButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSuggestButton), for: .touchUpInside)
        button.backgroundColor = UIColor.gray

        return button
    }()
    let discoverButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDiscoverButton), for: .touchUpInside)
        button.backgroundColor = UIColor.green

        return button
    }()
    let promotionView : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePromotionView), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow

        return button
    }()
    let listOfResortsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleListOfResortsButton), for: .touchUpInside)
        button.backgroundColor = UIColor.white

        return button
    }()
    
    func addContent(){
        let minumumItemSize = self.view.bounds.width / 3
        print(minumumItemSize)
        view.addSubview(sendRequestButton)
        view.addSubview(recruitmentButton)
        view.addSubview(introduceButton)
        view.addSubview(suggestButton)
        view.addSubview(discoverButton)
        view.addSubview(promotionView)
        view.addSubview(listOfResortsButton)
        
        //sendRequestButton contraint
        
//        view.addConstraintWithFormat(format: "V:|-20-|", views: <#T##UIView...##UIView#>)
        sendRequestButton.heightAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        sendRequestButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true;
        sendRequestButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true;
        sendRequestButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        //recruitmentButton contraint
        recruitmentButton.heightAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        recruitmentButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true;
        recruitmentButton.bottomAnchor.constraint(equalTo: sendRequestButton.topAnchor, constant: 0).isActive = true
        recruitmentButton.widthAnchor.constraint(equalToConstant: minumumItemSize * 2).isActive = true
        
        //introduceButton contraint
        introduceButton.heightAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        introduceButton.widthAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        introduceButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        introduceButton.bottomAnchor.constraint(equalTo: sendRequestButton.topAnchor, constant: 0).isActive = true
        
        //suggestButton contraint
        suggestButton.heightAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        suggestButton.widthAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        suggestButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true;
        suggestButton.bottomAnchor.constraint(equalTo: recruitmentButton.topAnchor, constant: 0).isActive = true
        //discoverButton contraint
        discoverButton.heightAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        discoverButton.widthAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        discoverButton.rightAnchor.constraint(equalTo: suggestButton.leftAnchor, constant: 0).isActive = true;
        discoverButton.bottomAnchor.constraint(equalTo: recruitmentButton.topAnchor, constant: 0).isActive = true
        //promotionView contraint
        promotionView.heightAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        promotionView.widthAnchor.constraint(equalToConstant: minumumItemSize).isActive = true
        promotionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        promotionView.bottomAnchor.constraint(equalTo: recruitmentButton.topAnchor, constant: 0).isActive = true

        //listOfResortsButton contraint
        listOfResortsButton.heightAnchor.constraint(equalToConstant: view.bounds.size.height - 20 - navHeight - view.bounds.size.width ).isActive = true
        listOfResortsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        listOfResortsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        listOfResortsButton.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0).isActive = true
        
        addButtonIcon()
    }
    
    func addButtonIcon(){
        
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
        
    }
    func handleSuggestButton(){
        print("handleSuggestButton")
    }
    func handleDiscoverButton(){
        print("handleDiscoverButton")
    }
    func handlePromotionView(){
        print("handlePromotionView")
    }
    func handleListOfResortsButton(){
        print("handleListOfResortsButton")
    }
    
    // nav event
    func navUserClick(){
        print("user click")
    }
    
    func navSettingsClick(){
        print("setting click")
    
    }
    
    func presentVC(viewContronller : BaseViewController) {
        let navVC : UINavigationController = UINavigationController(rootViewController: viewContronller)
        self.present(navVC, animated: true) { 
            //do something late
        }
    }
}
