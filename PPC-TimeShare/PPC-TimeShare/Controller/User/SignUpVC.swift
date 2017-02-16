//
//  SignUpVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SignUpVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
    }
    let inputSize : CGFloat = 60.0
    let spaceLine : CGFloat = 1.0
    
    let inputNameView : InputView = {
        let input = InputView()
        input.hint = "Name"
        
        return input
    }()
    let inputEmailView : InputView = {
        let input = InputView()
        input.hint = "Email"
        return input
    }()
    let inputMobileView : InputView = {
        let input = InputView()
        input.hint = "Mobile number"
        return input
    }()
    let inputAddressView : InputView = {
        let input = InputView()
        input.hint = "Address"
        return input
    }()
    let inputPasswordView : InputView = {
        let input = InputView()
        input.type = InputType.password
        input.hint = "123456"
        return input
    }()
    let inputComfirmPasswordView : InputView = {
        let input = InputView()
        input.type = InputType.password
        input.hint = "123456"
        return input
    }()
    
    let buttonAcceptTerms : MyButton = {
        let button = MyButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Accept terms", for: .normal)
        button.addTarget(self, action: #selector(handleAcceptTermsButton), for: .touchUpInside)
        return button
    }()
    let buttonSignIn : MyButton = {
        let button = MyButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(inputNameView)
        view.addSubview(inputEmailView)
        view.addSubview(inputMobileView)
        view.addSubview(inputAddressView)
        view.addSubview(inputPasswordView)
        view.addSubview(inputComfirmPasswordView)
        view.addSubview(buttonAcceptTerms)
        view.addSubview(buttonSignIn)
        
        inputNameView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputEmailView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputMobileView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputAddressView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputPasswordView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputComfirmPasswordView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputNameView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputMobileView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputAddressView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputPasswordView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputComfirmPasswordView)
        
        view.addConstraintWithFormat(format: "V:|-20-[v0]-\(spaceLine)-[v1]-\(spaceLine)-[v2]-\(spaceLine)-[v3]-\(spaceLine)-[v4]-\(spaceLine)-[v5]", views: inputNameView, inputEmailView, inputMobileView, inputAddressView, inputPasswordView, inputComfirmPasswordView)
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonAcceptTerms)
        buttonAcceptTerms.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonAcceptTerms.topAnchor.constraint(equalTo: inputComfirmPasswordView.bottomAnchor, constant: 0).isActive = true
        
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonSignIn)
        buttonSignIn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonSignIn.topAnchor.constraint(equalTo: buttonAcceptTerms.bottomAnchor, constant: 0).isActive = true
    }

    
    // handle button
    func handleAcceptTermsButton(){
        
    }
    func handleSignUpButton(){
        
    }
    
}
