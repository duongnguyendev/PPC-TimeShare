//
//  BaseViewController.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var presented : Bool?
    
    let languageManager = LanguageManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        hideKeyboarTouchupOutSide()
        setupNavBar()
        setupView()
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "Roboto-Medium", size: 20)!]

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.red
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        setupNavBackButton()
    }
    func goHome(){
        self.dismiss(animated: true) { 
            //do something here later
        }
    }
    func goBack(){
        
        if presented! {
            goHome()
        }
        else{
            if let navVC = self.navigationController{
                navVC.popViewController(animated: true)
            }
        }
        
        
    }
    func pushVC(viewController : BaseViewController)
    {
        viewController.presented = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func localizeString(){
    
    }
    func setupNavBackButton(){
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        if !presented! {
            setupGoHomeButton()
        }
    }
    func setupFilterButton(){
        let backButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(handleFilter))
        self.navigationItem.rightBarButtonItem = backButton
        
    }
    func setupGoHomeButton(){
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goHome))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func setupView() {
        
    }
    
    func handleFilter(){
        // filter us for sub view controller
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func hideKeyboarTouchupOutSide(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    

}
