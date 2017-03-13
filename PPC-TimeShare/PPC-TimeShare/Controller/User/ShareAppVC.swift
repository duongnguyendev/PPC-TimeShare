//
//  ShareAppVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ShareAppVC: BaseViewController {

    var user : User?{
        didSet{
            codeLable.text = user?.shareCode
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = languageManager.localizedString(string: "Share")
        // Do any additional setup after loading the view.
    }

    let textViewContent : UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.textAlignment = .justified
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont(name: "Roboto-Light", size: 14)
        tv.text = "Terms and Conditions are a set of rules and guidelines that a user must agree to in order to use your website or mobile app. It acts as a legal contract between you (the company) who has the website or mobile app and the user who access your website and mobile app.\n\nIt’s up to you to set the rules and guidelines that the user must agree to. You can think of your Terms and Conditions agreement as the legal agreement where you maintain your rights to exclude users from your app in the event that they abuse your app, and where you maintain your legal rights against potential app abusers, and so on."
        return tv
    }()
    let buttonShare : MyButton = {
        let button  = MyButton()
        button.backgroundColor = UIColor.button1Collor()
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "Share"), for: .normal)
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return button
    }()
    let codeLable : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    override func setupView() {
        view.addSubview(textViewContent)
        view.addSubview(codeLable)
        view.addSubview(buttonShare)
        
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: textViewContent)
        view.addConstraintWithFormat(format: "H:|-100-[v0]-100-|", views: codeLable)
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonShare)
        view.addConstraintWithFormat(format: "V:|-15-[v0]-20-[v1(40)]-20-[v2(40)]-20-|", views: textViewContent, codeLable, buttonShare)
    }
    
    func handleShare(){
        
        let text = "This is some text that I want to share.\n\(user?.shareCode)"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
