//
//  SignUp_3VC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SignUp_3VC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign up"
    }
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.text = "Terms and conditions"
        label.font = UIFont(name: "Roboto-Light", size: 14)
        return label
   
    }()
    
    let textViewContent : UITextView = {
        let textView = UITextView()
        textView.text = "Terms and Conditions are a set of rules and guidelines that a user must agree to in order to use your website or mobile app. It acts as a legal contract between you (the company) who has the website or mobile app and the user who access your website and mobile app.\n\nIt’s up to you to set the rules and guidelines that the user must agree to. You can think of your Terms and Conditions agreement as the legal agreement where you maintain your rights to exclude users from your app in the event that they abuse your app, and where you maintain your legal rights against potential app abusers, and so on.\n\nThis type of legal agreement can be used for both your website and your mobile app. It’s not required (it’s not recommended actually) to have separate Terms and Conditions agreements: one for your website and one for your mobile app."
        
        textView.font = UIFont(name: "Roboto-Light", size: 14)
        textView.textAlignment = .justified
        return textView
    }()
    
    let buttonComplete : MyButton = {
        let button = MyButton()
        button.setTitle("Complete", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 189, green: 218, blue: 2)
        button.addTarget(self, action: #selector(handleCompleteButton), for: .touchUpInside)
        return button
    }()

    override func setupView() {
        view.addSubview(labelTitle)
        view.addSubview(textViewContent)
        view.addSubview(buttonComplete)
        
        view.addConstraintWithFormat(format: "H:|-5-[v0]|", views: labelTitle)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: textViewContent)
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonComplete)
        view.addConstraintWithFormat(format: "V:|[v0(40)][v1]-20-[v2(40)]-20-|", views: labelTitle, textViewContent, buttonComplete)
    }
    
    func handleCompleteButton(){
        print("handleCompleteButton")
    }
}
