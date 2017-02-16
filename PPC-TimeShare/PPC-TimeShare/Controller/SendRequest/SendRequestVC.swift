//
//  SendRequestVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SendRequestVC: BaseViewController {

    let itemHeight : CGFloat = 40
    let spaceLine : CGFloat = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send Request"
    }
    
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
        input.hint = "Mobile"
        return input
    }()
    let inputTitleView : InputView = {
        let input = InputView()
        input.hint = "Title"
        return input
    }()
    
    
    let sendButton : MyButton = {
        let button = MyButton()
        button.setTitle("Send", for: .normal)
        button.backgroundColor = UIColor.green
        return button
    }()
    let contentTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Roboto-Light", size: 14)
        textView.text = "Compose request"
        return textView
    }()
    
    override func setupView() {
        view.addSubview(inputNameView)
        view.addSubview(inputEmailView)
        view.addSubview(inputMobileView)
        view.addSubview(inputTitleView)
        
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        view.addSubview(whiteView)
        
        inputNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputNameView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputMobileView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputTitleView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: whiteView)
        
        view.addConstraintWithFormat(format: "V:[v0(\(itemHeight))]-\(spaceLine)-[v1(\(itemHeight))]-\(spaceLine)-[v2(\(itemHeight))]-\(spaceLine)-[v3(\(itemHeight))]-2-[v4]|", views: inputNameView, inputEmailView, inputMobileView, inputTitleView, whiteView)
        
        whiteView.addSubview(sendButton)
        whiteView.addSubview(contentTextView)
        
        sendButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whiteView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: sendButton)
        sendButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -20).isActive = true
        
        whiteView.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: contentTextView)
        contentTextView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 0).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20).isActive = true
    }
}
