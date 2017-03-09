//
//  UserProfileVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class UserProfileVC: BaseViewController, UITextFieldDelegate, InputViewDelegate, DropDownDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user : User?{
        didSet{
            if user?.avartarUrl != nil && user?.avartarUrl != ""{
                self.imageViewAvatar.loadImageUsingUrlString(urlString: (user?.avartarUrl)!)
            }
            inputNameView.string = user?.userName
            inputMobileView.string = user?.mobileNumber
            inputAddressView.string = user?.address
            buttonGender.title = user?.gender?.genderValue
        }
    }
    
    
    override func setupNavBar() {
        super.setupNavBar()
        setupHistoryButton()

    }
    
    func setupHistoryButton(){
        
        let historyButton = barButton(iconName: "icon_history")
        historyButton.addTarget(self, action: #selector(handleHistory), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: historyButton)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    let itemSize : CGFloat = 45.0
    let spaceLine : CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAvatarClick))
        imageViewAvatar.isUserInteractionEnabled = true
        imageViewAvatar.addGestureRecognizer(tap)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationBar = navigationController?.navigationBar{
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
        }
        
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
    let imageBackgroup : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bg_avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    let imageViewAvatar : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "icon_avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let userTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Membership: Sliver"
        label.font = UIFont(name: "Roboto-Light", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var inputNameView : InputView = {
        let input = InputView()
        input.iconName = "name_icon"
        input.hint = "Name"
        input.editAble = false
        input.editControllButton.isHidden = false
        input.textField.delegate = self
        input.delegate = self
        
        return input
    }()
    
    lazy var inputMobileView : InputView = {
        let input = InputView()
        input.iconName = "mobile_number_icon"
        input.hint = "Mobile number"
        input.editAble = false
        input.editControllButton.isHidden = false
        input.textField.delegate = self
        input.delegate = self
        return input
    }()
    
    let buttonGender : InfoButton = {
        let button = InfoButton()
        button.labelTitle.font = UIFont(name: "Roboto-Light", size: 14)
        button.iconName = "gender_icon"
        button.addTarget(self, action: #selector(handleButtonGender), for: .touchUpInside)
        button.title = "Gender" // title = value
        button.value = ""
        return button
    }()
    
    lazy var inputAddressView : InputView = {
        let input = InputView()
        input.iconName = "adress_icon_1"
        input.hint = "Address"
        input.editAble = false
        input.editControllButton.isHidden = false
        input.textField.delegate = self
        input.delegate = self
        return input
    }()
    
    let buttonUpdate : MyButton = {
        let button = MyButton()
        button.setTitle("Update", for: .normal)
        button.backgroundColor = UIColor.button1Collor()
        button.addTarget(self, action: #selector(handleUpdateButton), for: .touchUpInside)
        return button
    }()
    
    let buttonYourVoucher : InfoButton = {
        let button = InfoButton()
        button.labelTitle.font = UIFont(name: "Roboto-Light", size: 14)
        button.iconName = "icon_gift"
        button.addTarget(self, action: #selector(handleButtonVoucher), for: .touchUpInside)
        button.title = "Your voucher" // title = value
        button.value = ""
        return button
    }()
    let buttonShareYourApp : InfoButton = {
        let button = InfoButton()
        button.labelTitle.font = UIFont(name: "Roboto-Light", size: 14)
        button.iconName = "icon_share"
        button.addTarget(self, action: #selector(handleButtonShare), for: .touchUpInside)
        button.title = "Share your app" // title = value
        button.value = ""
        return button
    }()
    
    
    let genderDropDown = GenderDropDown ()
    
    
    
    override func setupView() {
        let avatarSize : CGFloat = 100
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainContentView)
        
        //scrollView
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -44 ).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        // contentView
        
        mainContentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        mainContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        mainContentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        mainContentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        
        mainContentView.addSubview(imageBackgroup)
        mainContentView.addSubview(imageViewAvatar)
        mainContentView.addSubview(userTypeLabel)
        mainContentView.addSubview(inputNameView)
        mainContentView.addSubview(buttonGender)
        mainContentView.addSubview(inputMobileView)
        mainContentView.addSubview(inputAddressView)
        mainContentView.addSubview(buttonUpdate)
        mainContentView.addSubview(buttonYourVoucher)
        mainContentView.addSubview(buttonShareYourApp)
        
        // imageBackgroup
        imageBackgroup.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 0).isActive = true
        imageBackgroup.leftAnchor.constraint(equalTo: mainContentView.leftAnchor, constant: 0).isActive = true
        imageBackgroup.rightAnchor.constraint(equalTo: mainContentView.rightAnchor, constant: 0).isActive = true
        imageBackgroup.bottomAnchor.constraint(equalTo: imageViewAvatar.topAnchor, constant: avatarSize / 2).isActive = true
        
        //imageViewAvatar
        
        imageViewAvatar.layer.cornerRadius = avatarSize / 2
        imageViewAvatar.layer.masksToBounds = true
        
        imageViewAvatar.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 64).isActive = true
        mainContentView.addConstraint(NSLayoutConstraint(item: imageViewAvatar, attribute: .centerX, relatedBy: .equal, toItem: mainContentView, attribute: .centerX, multiplier: 1, constant: 0))
        imageViewAvatar.heightAnchor.constraint(equalToConstant: avatarSize).isActive = true
        imageViewAvatar.widthAnchor.constraint(equalToConstant: avatarSize).isActive = true
        
        // input view
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: userTypeLabel)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputNameView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonGender)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputMobileView)
        mainContentView.addConstraintWithFormat(format: "H:|[v0]|", views: inputAddressView)
        mainContentView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonUpdate)
        
        mainContentView.addConstraintWithFormat(format: "H:|[v0]", views: buttonYourVoucher)
        buttonYourVoucher.rightAnchor.constraint(equalTo: mainContentView.rightAnchor, constant: 40).isActive = true
        mainContentView.addConstraintWithFormat(format: "H:|[v0]", views: buttonShareYourApp)
        buttonShareYourApp.rightAnchor.constraint(equalTo: mainContentView.rightAnchor, constant: 40).isActive = true
        
        userTypeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userTypeLabel.topAnchor.constraint(equalTo: imageViewAvatar.bottomAnchor, constant: 0).isActive = true
        inputNameView.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonGender.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        inputMobileView.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        inputAddressView.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonShareYourApp.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonYourVoucher.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "V:[v0]-\(spaceLine)-[v1]-\(spaceLine)-[v2]-\(spaceLine)-[v3]-\(spaceLine)-[v4]-\(spaceLine)-[v5]-\(spaceLine)-[v6]-20-[v7(40)]-20-|", views: userTypeLabel, inputNameView, buttonGender, inputMobileView, inputAddressView, buttonYourVoucher, buttonShareYourApp, buttonUpdate)
        
        buttonUpdate.isHidden = true
        
        
        mainContentView.addSubview(genderDropDown)
        genderDropDown.delegate = self
        genderDropDown.topAnchor.constraint(equalTo: buttonGender.bottomAnchor, constant: 1).isActive = true
        genderDropDown.leftAnchor.constraint(equalTo: buttonGender.leftAnchor, constant: 40).isActive = true
        genderDropDown.rightAnchor.constraint(equalTo: buttonGender.rightAnchor, constant: 0).isActive = true
        genderDropDown.heightAnchor.constraint(equalToConstant: 83).isActive = true
        
        
        super.setupView()
    }
    
    func handleUpdateButton(){
        self.user?.userName = self.inputNameView.textField.text
        self.user?.address = self.inputAddressView.textField.text
        self.user?.mobileNumber = self.inputMobileView.textField.text
        // gender update when select
        self.activity.startAnimating()
        APIService.sharedInstance.requestUpdate(user: self.user!) { (userUpdated, errorMes) in
            self.activity.stopAnimating()
            var alert : UIAlertController?
            if errorMes != nil{
                alert = UIAlertController(title: "Cập nhật thất bại", message: "Vui lòng thử lại!", preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                    
                }))
            
            }else{
                let userDic = userUpdated?.toDictionary()
                UserDefaults.standard.set(userDic, forKey: "currentUser")
                alert = UIAlertController(title: "Cập nhật thành công", message: "Thông tin của bạn đã được cập nhật", preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                    
                }))
            }
            self.present(alert!, animated: true, completion: nil)
        }
        
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        var contentInsets = UIEdgeInsets.zero
        contentInsets.top = 64
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            contentInsets.top = 64
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!aRect.contains(activeField.frame.origin)) {
                self.mainScrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func handleButtonGender(){
        if genderDropDown.isHidden {
            genderDropDown.isHidden = false
        }else{
            genderDropDown.isHidden = true
        }
    }
    
    func handleButtonShare() {
        view.endEditing(true)
        let shareVC = ShareAppVC()
        shareVC.user = self.user
        self.pushVC(viewController: shareVC)
    }
    func handleButtonVoucher() {
        view.endEditing(true)
        let voucherVC = YourVoucherVC()
        voucherVC.userId = self.user?.userId
        self.pushVC(viewController: voucherVC)
    }
    
    func input(edited: Bool) {
        if edited {
            self.buttonUpdate.isHidden = false
        }
    }
    func selected(gender: Gender) {
        if self.user?.gender?.genderId != gender.genderId {
            buttonUpdate.isHidden = false
            self.user?.gender = gender
            buttonGender.title = gender.genderValue
        }
    }
    
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
            self.user?.avartarUrl = base64String
            self.buttonUpdate.isHidden = false
            picker.dismiss(animated: true, completion: nil)
        }else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    override func localizeString() {
        title = "Profile"
    }
    override func hideKeyboarTouchupOutSide() {
        
    }
    
    func handleHistory() {
        let historyVC = HistoryVC()
        historyVC.userId = self.user?.userId
        self.pushVC(viewController: historyVC)
    }
    
}
