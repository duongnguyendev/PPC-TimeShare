//
//  SignUp_2VC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SignUp_2VC: BaseViewController, UITextFieldDelegate, DropDownDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let itemSize : CGFloat = 60.0
    let spaceLine : CGFloat = 1.0
    var user = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAvatarClick))
        imageViewAvatar.isUserInteractionEnabled = true
        imageViewAvatar.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
        localizeString()
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
        let iv = UIImageView(image: UIImage(named: "icon_avatar"))
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
        button.addTarget(self, action: #selector(handleGenderButton), for: .touchUpInside)
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
    
    let genderDropDown = GenderDropDown ()
    
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
        
        mainContentView.addSubview(genderDropDown)
        genderDropDown.delegate = self
        genderDropDown.topAnchor.constraint(equalTo: buttonGender.bottomAnchor, constant: 1).isActive = true
        genderDropDown.leftAnchor.constraint(equalTo: buttonGender.leftAnchor, constant: 40).isActive = true
        genderDropDown.rightAnchor.constraint(equalTo: buttonGender.rightAnchor, constant: 0).isActive = true
        genderDropDown.heightAnchor.constraint(equalToConstant: 63).isActive = true
        
        

    }
    
    func handleNextButton(){
        dismissKeyboard()
        if let validateMes = validate(){
            print(validateMes)
        }else{
            self.user.address = self.inputAddressView.textField.text
            self.user.userName = self.inputNameView.textField.text
            self.user.mobileNumber = self.inputMobileView.textField.text
            let signUP_3VC = SignUp_3VC()
            signUP_3VC.user = self.user
            pushVC(viewController: signUP_3VC)
        }
    }
    
    func handleGenderButton(){
        if genderDropDown.isHidden {
            genderDropDown.isHidden = false
        }else{
            genderDropDown.isHidden = true
        }
    }
    // avatar handle
    func handleAvatarClick(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Select image", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo libary", style: .default, handler: { (action) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                print("camera unavailable")
            }
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            let avatarImage = image.resize(newWidth: 500)
            imageViewAvatar.image = avatarImage
            let imageData = UIImagePNGRepresentation(avatarImage)
            let base64String = imageData?.base64EncodedString(options: .init(rawValue: 0))
            self.user.avartarUrl = base64String
            picker.dismiss(animated: true, completion: nil)
        }else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        genderDropDown.hide()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    //validate
    func validate() -> String?{
        
        if (validateUserName() != nil) {
            return validateUserName()
        }
        if (validateMobile() != nil) {
            return validateMobile()
        }
        if (validateGender() != nil) {
            return validateGender()
        }
        if (validateAddress() != nil) {
            return validateAddress()
        }
        return nil
    }
    
    func validateUserName() ->String?{
        if (inputNameView.textField.text?.characters.count)! < 2 {
            return "user name invalid"
        }
        return nil
    }
    func validateMobile() ->String? {
        let mobileFormat = "^\\d{10,11}$"
        
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileFormat)
        let mobileTestResult = mobileTest.evaluate(with: inputMobileView.textField.text)
        if !mobileTestResult {
            return "mobile number invalid"
        }
        return nil
    }
    func validateGender() -> String? {
        if self.user.gender == nil{
            return "please select gender"
        }
        return nil
    }
    func validateAddress() ->String?{
        if (inputAddressView.textField.text?.isEmpty)! {
            return "please type address"
        }
        return nil
    }
    func selected(gender: Gender) {
        genderDropDown.hide()
        self.user.gender = gender
        buttonGender.title = gender.genderValue
    }
    override func hideKeyboarTouchupOutSide() {
        
    }
}
