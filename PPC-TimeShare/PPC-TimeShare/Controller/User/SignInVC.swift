//
//  SingInVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

@objc protocol SignInDelegate {
    
    @objc optional func signInWith(user: User)
}

class SignInVC: BaseViewController {

    var delegate : SignInDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.sharedInstance.localizedString(string: "SignIn")
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
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "ForgotPassword"), for: .normal)
        button.addTarget(self, action: #selector(handleForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    let buttonSignIn : MyButton = {
        let button = MyButton()
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "SignIn"), for: .normal)
        button.backgroundColor = UIColor.button1Collor()
        button.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return button
    }()
    
    let buttonSignUp : MyButton = {
        let button = MyButton()
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "SignUp"), for: .normal)
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        button.backgroundColor = UIColor.button2Collor()
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
        self.view.endEditing(true)
        let email = inputEmailView.textField.text
        let password = inputPasswordView.textField.text
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        self.activity.startAnimating()
        APIService.sharedInstance.requestSignIn(email: email!, passWord: password!) { (user, errorMes) in
            self.activity.stopAnimating()
            if errorMes != nil{
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.title = self.languageManager.localizedString(string: "LogedInFailed")
                alert.message = errorMes
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: { 
                    //do something
                })
                
            }else{
                
                let userDic = user?.toDictionary()
                UserDefaults.standard.set(userDic, forKey: "currentUser")
                UserDefaults.standard.set(user?.token, forKey: "token")
                if self.delegate != nil {
                    self.delegate?.signInWith!(user: user!)
                }
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                    self.goHome()
                })
                alert.message = self.languageManager.localizedString(string: "LogInSuccessfully")
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: { 
                    //do something
                })
                
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
