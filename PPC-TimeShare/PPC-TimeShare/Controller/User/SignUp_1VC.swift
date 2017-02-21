//
//  SignUpVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SignUp_1VC: BaseViewController, UITextFieldDelegate{
    
    var scrollViewBottomContent : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign up"
    }
    let inputSize : CGFloat = 60.0
    let spaceLine : CGFloat = 1.0
    
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let mainContentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inputEmailView : InputView = {
        let input = InputView()
        input.iconName = "your_email_icon"
        input.hint = "Email"
        input.textField.delegate = self
        return input
    }()
    
    lazy var inputPasswordView : InputView = {
        let input = InputView()
        input.iconName = "password_icon"
        input.type = InputType.password
        input.hint = "Password"
        input.textField.delegate = self
        return input
    }()
    lazy var inputComfirmPasswordView : InputView = {
        let input = InputView()
        input.iconName = "confirm_password_icon"
        input.type = InputType.password
        input.hint = "Confirm password"
        input.textField.delegate = self
        return input
    }()
    
    let buttonNext : MyButton = {
        let button = MyButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return button
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainContentView)
        
        mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        mainContentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        mainContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        mainContentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        mainContentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        mainContentView.addSubview(inputEmailView)
        mainContentView.addSubview(inputPasswordView)
        mainContentView.addSubview(inputComfirmPasswordView)
        mainContentView.addSubview(buttonNext)
        
        inputEmailView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputPasswordView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputComfirmPasswordView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputPasswordView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputComfirmPasswordView)
        mainContentView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonNext)
        
        mainContentView.addConstraintWithFormat(format: "V:|-20-[v0]-\(spaceLine)-[v1]-\(spaceLine)-[v2]-20-[v3(40)]-20-|", views: inputEmailView,inputPasswordView, inputComfirmPasswordView, buttonNext)
    }
    
    
    // handle button
    func handleAcceptTermsButton(){
        
    }
    func handleNextButton(){
        let signUp_2VC : SignUp_2VC = SignUp_2VC()
        pushVC(viewController: signUp_2VC)
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!aRect.contains(activeField.frame.origin)) {
                self.mainScrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
}
