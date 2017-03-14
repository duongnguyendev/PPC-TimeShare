//
//  BaseViewController.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    weak var activeField: UITextField?
    var presented : Bool?
    let languageManager = LanguageManager.sharedInstance
    let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        hideKeyboarTouchupOutSide()
        setupNavBar()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        localizeString()
        
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "Roboto-Medium", size: 17)!]

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.appStyleColor()
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
        NotificationCenter.default.removeObserver(self)
    }
    
    func presentVC(viewController : BaseViewController) {
        viewController.presented = true
        let navVC : UINavigationController = UINavigationController(rootViewController: viewController)
        self.present(navVC, animated: true) {
            
        }
    }
    
    func setupNavBackButton(){
        
        let backButton = barButton(iconName: "back_icon")
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButtonItem
        
        if !presented! {
            setupGoHomeButton()
        }
    }
    func setupGoHomeButton(){
        let homeButton = barButton(iconName: "home_icon")
        homeButton.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func setupView() {
        view.addSubview(activity)
        activity.layer.zPosition = 1
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        self.activity.hidesWhenStopped = true
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func hideKeyboarTouchupOutSide(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func barButton(iconName : String) -> UIButton{
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        let iconImage : UIImage = (UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal))!
        
        button.setBackgroundImage(iconImage, for: .normal)
        return button
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    //localizeString
    func localizeString(){
        
    }
}
