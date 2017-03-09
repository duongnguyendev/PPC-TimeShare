//
//  ForgotPasswordVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Forgot Password"
    }
    let inputSize : CGFloat = 60.0
    let spaceLine : CGFloat = 1.0
    
    let inputEmailView : InputView = {
        let input = InputView()
        input.iconName = "your_email_icon"
        input.hint = "Your Email"
        return input
    }()
    
    let buttonConfirm : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.button1Collor()
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
        return button
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(inputEmailView)
        view.addSubview(buttonConfirm)
        
        
        inputEmailView.heightAnchor.constraint(equalToConstant: inputSize).isActive = true
        
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        
        view.addConstraintWithFormat(format: "V:|-20-[v0]", views: inputEmailView)
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonConfirm)
        buttonConfirm.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonConfirm.topAnchor.constraint(equalTo: inputEmailView.bottomAnchor, constant: 20).isActive = true

    }
    func handleConfirmButton(){
        self.activity.startAnimating()
        if (self.inputEmailView.textField.text?.characters.count)! > 0 {
            APIService.sharedInstance.requestForgotPass(email: self.inputEmailView.textField.text!, completion: { (success) in
                self.activity.stopAnimating()
                if success{
                    let alert = UIAlertController(title: "Thông báo", message: "Yêu cầu gửi thành công. Vui lòng kiểm tra email của bạn", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (nil) in                    }))
                    self.present(alert, animated: true, completion: {
                        self.goHome()
                    })
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: "Yêu cầu gửi thất bại. Vui lòng thử lại", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (nil) in
                    }))
                    self.present(alert, animated: true, completion: {
                        
                    })
                }
            })
        }
    }
}
