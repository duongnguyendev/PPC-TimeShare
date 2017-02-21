//
//  SignUp_2VC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SignUp_2VC: BaseViewController, UITextFieldDelegate {
    
    let itemSize : CGFloat = 60.0
    let spaceLine : CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign up"
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
    
    let imageViewAvatar : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "resort"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let updateProFilePictureLabel : UILabel = {
        let label = UILabel()
        label.text = "UPDATE PROFILE PICTURE"
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var inputNameView : InputView = {
        let input = InputView()
        input.iconName = "name_icon"
        input.hint = "Name"
        input.textField.delegate = self
        
        return input
    }()
    
    lazy var inputMobileView : InputView = {
        let input = InputView()
        input.iconName = "mobile_number_icon"
        input.hint = "Mobile number"
        input.textField.delegate = self
        return input
    }()
    
    let buttonGender : InfoButton = {
        let button = InfoButton()
        button.labelTitle.font = UIFont(name: "Roboto-Light", size: 14)
        button.iconName = "gender_icon"
        button.title = "Gender" // title = value
        button.value = ""
        return button
    }()
    
    lazy var inputAddressView : InputView = {
        let input = InputView()
        input.iconName = "adress_icon_1"
        input.hint = "Address"
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
        
        mainContentView.addSubview(imageViewAvatar)
        let avatarSize : CGFloat = 100
        mainContentView.addSubview(updateProFilePictureLabel)
        mainContentView.addSubview(inputNameView)
        mainContentView.addSubview(buttonGender)
        mainContentView.addSubview(inputMobileView)
        mainContentView.addSubview(inputAddressView)
        mainContentView.addSubview(buttonNext)
        
        imageViewAvatar.layer.cornerRadius = avatarSize / 2
        imageViewAvatar.layer.masksToBounds = true
        
        imageViewAvatar.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 20).isActive = true
        mainContentView.addConstraint(NSLayoutConstraint(item: imageViewAvatar, attribute: .centerX, relatedBy: .equal, toItem: mainContentView, attribute: .centerX, multiplier: 1, constant: 0))
        imageViewAvatar.heightAnchor.constraint(equalToConstant: avatarSize).isActive = true
        imageViewAvatar.widthAnchor.constraint(equalToConstant: avatarSize).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: updateProFilePictureLabel)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputNameView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonGender)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputMobileView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputAddressView)
        mainContentView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonNext)
        
        
        updateProFilePictureLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        updateProFilePictureLabel.topAnchor.constraint(equalTo: imageViewAvatar.bottomAnchor, constant: 0).isActive = true
        inputNameView.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonGender.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        inputMobileView.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        inputAddressView.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "V:[v0]-\(spaceLine)-[v1]-\(spaceLine)-[v2]-\(spaceLine)-[v3]-\(spaceLine)-[v4]-20-[v5(40)]-20-|", views: updateProFilePictureLabel, inputNameView, buttonGender, inputMobileView, inputAddressView, buttonNext)

    }
    
    func handleNextButton(){
        let signUP_3VC = SignUp_3VC()
        
        pushVC(viewController: signUP_3VC)
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
