//
//  SingInVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SignInVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
    }
    let inputSize : CGFloat = 60.0
    let spaceLine : CGFloat = 1.0
    let inputEmailView : InputView = {
        let input = InputView()
        input.hint = "Email"
        input.iconName = "your_email_icon"
        return input
    }()
    let inputPasswordView : InputView = {
        let input = InputView()
        input.type = InputType.password
        input.hint = "Password"
        input.iconName = "password_icon"
        return input
    }()
    
    let buttonForgotPassword : MyButton = {
        let button = MyButton()
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Forgot Password?", for: .normal)
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    let buttonSignIn : MyButton = {
        let button = MyButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return button
    }()
    
    let buttonSignUp : MyButton = {
        let button = MyButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(inputEmailView)
        view.addSubview(inputPasswordView)
        view.addSubview(buttonForgotPassword)
        view.addSubview(buttonSignIn)
        view.addSubview(buttonSignUp)
        
        inputEmailView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        inputPasswordView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputPasswordView)
        
        view.addConstraintWithFormat(format: "V:|-20-[v0]-\(spaceLine)-[v1]", views: inputEmailView, inputPasswordView)
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonForgotPassword)
        buttonForgotPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonForgotPassword.topAnchor.constraint(equalTo: inputPasswordView.bottomAnchor, constant: 0).isActive = true
        
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonSignIn)
        buttonSignIn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonSignIn.topAnchor.constraint(equalTo: buttonForgotPassword.bottomAnchor, constant: 0).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonSignUp)
        buttonSignUp.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonSignUp.topAnchor.constraint(equalTo: buttonSignIn.bottomAnchor, constant: 20).isActive = true
    }
    
    //handle button
    
    func handleSignInButton(){
        let email = inputEmailView.textField.text
        let password = inputPasswordView.textField.text
        APIService.sharedInstance.requestSignIn(email: email!, passWord: password!) { (user, errorMes) in
            if errorMes != nil{
                //show message
                print(errorMes as Any)
                
            }else{
                // go home
                let userDic = user?.toDictionary()
                UserDefaults.standard.set(userDic, forKey: "currentUser")
                UserDefaults.standard.set(user?.token, forKey: "token")
                self.goHome()
            }
        }
        
    }
    func handleSignUpButton(){
        let signUpVC : SignUp_1VC = SignUp_1VC()
        pushVC(viewController: signUpVC)
        
    }
    func handleForgotPasswordButton(){
        let forgotPasswordVC = ForgotPasswordVC()
        pushVC(viewController: forgotPasswordVC)
    }

}
