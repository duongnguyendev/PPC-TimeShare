//
//  SendRequestVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SendRequestVC: BaseViewController, UITextFieldDelegate {

    let itemHeight : CGFloat = 40
    let spaceLine : CGFloat = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send Request"
    }
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
    
    lazy var inputNameView : InputView = {
        let input = InputView()
        input.iconName = "name_icon"
        input.hint = "Name"
        input.textField.delegate = self
        return input
    }()
    lazy var inputEmailView : InputView = {
        let input = InputView()
        input.iconName = "your_email_icon"
        input.hint = "Email"
        input.textField.delegate = self
        return input
    }()
    lazy var inputMobileView : InputView = {
        let input = InputView()
        input.iconName = "mobile_number_icon"
        input.hint = "Mobile"
        input.textField.delegate = self
        return input
    }()
    lazy var inputTitleView : InputView = {
        let input = InputView()
        input.iconName = "title_icon"
        input.hint = "Title"
        input.textField.delegate = self
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
        
        mainContentView.addSubview(inputNameView)
        mainContentView.addSubview(inputEmailView)
        mainContentView.addSubview(inputMobileView)
        mainContentView.addSubview(inputTitleView)
        
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        mainContentView.addSubview(whiteView)
        
        inputNameView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 20).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputNameView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputMobileView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputTitleView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: whiteView)
        let textViewHeight = view.frame.height - (itemHeight * 4 + 20 + spaceLine * 5) - 64
        mainContentView.addConstraintWithFormat(format: "V:[v0(\(itemHeight))]-\(spaceLine)-[v1(\(itemHeight))]-\(spaceLine)-[v2(\(itemHeight))]-\(spaceLine)-[v3(\(itemHeight))]-2-[v4(\(textViewHeight))]|", views: inputNameView, inputEmailView, inputMobileView, inputTitleView, whiteView)
        
        whiteView.addSubview(sendButton)
        whiteView.addSubview(contentTextView)
        
        sendButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whiteView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: sendButton)
        sendButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -20).isActive = true
        
        whiteView.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: contentTextView)
        contentTextView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 0).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20).isActive = true
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    override func keyboardWillShow(notification: NSNotification) {
//        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
//            self.mainScrollView.contentInset = contentInsets
//            self.mainScrollView.scrollIndicatorInsets = contentInsets
//            var aRect = self.view.frame
//            aRect.size.height -= keyboardSize.size.height
//            if (!aRect.contains(activeField.frame.origin)) {
//                self.mainScrollView.scrollRectToVisible(activeField.frame, animated: true)
//            }
//        }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
//            if (!aRect.contains(activeField.frame.origin)) {
//                self.mainScrollView.scrollRectToVisible(activeField.frame, animated: true)
//            }
        }
        
    }
}
