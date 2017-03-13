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

        title = LanguageManager.sharedInstance.localizedString(string: "SignUp") 
    }
    var user: User = User()
    let labelTitle : UILabel = {
        let label = UILabel()
        label.text = LanguageManager.sharedInstance.localizedString(string: "TermsAndConditions")
        label.font = UIFont(name: "Roboto-Light", size: 16)
        return label
   
    }()
    
    let textViewContent : UITextView = {
        let textView = UITextView()
        textView.text = "Terms and Conditions are a set of rules and guidelines that a user must agree to in order to use your website or mobile app. It acts as a legal contract between you (the company) who has the website or mobile app and the user who access your website and mobile app.\n\nIt’s up to you to set the rules and guidelines that the user must agree to. You can think of your Terms and Conditions agreement as the legal agreement where you maintain your rights to exclude users from your app in the event that they abuse your app, and where you maintain your legal rights against potential app abusers, and so on.\n\nThis type of legal agreement can be used for both your website and your mobile app. It’s not required (it’s not recommended actually) to have separate Terms and Conditions agreements: one for your website and one for your mobile app."
        textView.isEditable = false
        textView.font = UIFont(name: "Roboto-Light", size: 16)
        textView.textAlignment = .justified
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let buttonTerms : ButtonCheckBook = {
        let button = ButtonCheckBook()
        button.addTarget(self, action: #selector(handleTermsButton), for: .touchUpInside)
        button.title = "AcceptTerms"
        button.isSelected = false
        return button
    }()
    let buttonComplete : MyButton = {
        let button = MyButton()
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "Complete"), for: .normal)
        button.backgroundColor = UIColor.button1Collor()
        button.addTarget(self, action: #selector(handleCompleteButton), for: .touchUpInside)
        return button
    }()

    override func setupView() {
        super.setupView()
        let textViewBackGround = UIView()
        textViewBackGround.translatesAutoresizingMaskIntoConstraints = false
        textViewBackGround.backgroundColor = UIColor.white
        view.addSubview(textViewBackGround)
        
        view.addSubview(labelTitle)
        textViewBackGround.addSubview(textViewContent)
        view.addSubview(buttonComplete)
        view.addSubview(buttonTerms)
        
        textViewBackGround.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: textViewContent)
        textViewBackGround.addConstraintWithFormat(format: "V:|[v0]|", views: textViewContent)

        view.addConstraintWithFormat(format: "H:|-20-[v0]|", views: labelTitle)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: textViewBackGround)
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonComplete)
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonTerms)
        
        view.addConstraintWithFormat(format: "V:|[v0(40)][v1]-20-[v2(40)]-10-[v3(40)]-20-|", views: labelTitle, textViewBackGround, buttonTerms, buttonComplete)
        
    }
    
    func handleTermsButton(){
        if buttonTerms.isSelected {
            buttonTerms.isSelected = false
        }else{
            buttonTerms.isSelected = true
        }
    }
    
    func handleCompleteButton(){
        var alert : UIAlertController?
        if buttonTerms.isSelected == false {
            alert = UIAlertController(title: self.languageManager.localizedString(string: "Notification"),
                                      message: self.languageManager.localizedString(string: "YouMustAcceptTermsOfUse"),
                                      preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (nil) in

            }))
            self.present(alert!, animated: true, completion: {
                
            })
            return
        }
        self.activity.startAnimating()
        APIService.sharedInstance.requestSignUp(user: self.user, completion: { (signUpUser, errorMes) in
            self.activity.stopAnimating()
            
            if errorMes != nil{
                //show error
                alert = UIAlertController(title: self.languageManager.localizedString(string: "Notifications"),
                                          message: self.languageManager.localizedString(string: "SignedUpFailed"), preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (nil) in
                    
                }))
                self.present(alert!, animated: true, completion: {
                    
                })
            }else{
                
                let userDic = signUpUser?.toDictionary()
                UserDefaults.standard.set(userDic, forKey: "currentUser")
                UserDefaults.standard.set(signUpUser?.token, forKey: "token")
                
                alert = UIAlertController(title: self.languageManager.localizedString(string: "Notifications"),
                                          message: self.languageManager.localizedString(string: "SignedUpSuccessfully"), preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (nil) in
                    self.goHome()
                }))
                self.present(alert!, animated: true, completion: { 
                    
                })
                //do some thing
            }
            
        })
    }
}


