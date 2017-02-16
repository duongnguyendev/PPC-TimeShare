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
        input.hint = "Your Email"
        return input
    }()
    
    let buttonConfirm : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.blue
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
        
    }
}
