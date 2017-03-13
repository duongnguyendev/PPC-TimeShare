//
//  SendRequestVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SendRequestVC: BaseViewController, UITextFieldDelegate {

    let itemHeight : CGFloat = 50
    let spaceLine : CGFloat = 1
    var user : User?{
        didSet{
            self.inputEmailView.textField.text = user?.email
            self.inputNameView.textField.text = user?.userName
            self.inputMobileView.textField.text = user?.mobileNumber
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = languageManager.localizedString(string: "SendRequest")
        
        let userInfo = UserDefaults.standard.value(forKey: "currentUser")
        if userInfo != nil{
            let user = User(data: userInfo as! Dictionary <String, Any>)
            self.user = user
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
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "Send"), for: .normal)
        button.addTarget(self, action: #selector(handleButtonSend), for: .touchUpInside)
        button.backgroundColor = UIColor.button1Collor()
        return button
    }()
    let contentTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Roboto-Light", size: 14)
        textView.text = LanguageManager.sharedInstance.localizedString(string: "ComposeRequest")
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
    
    func handleButtonSend(){
        let alter = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alter.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        let validateMes = validate()
        if validateMes == nil{
            let name = self.inputNameView.textField.text
            let email = self.inputEmailView.textField.text
            let mobile = self.inputMobileView.textField.text
            let title = self.inputTitleView.textField.text
            let content = self.contentTextView.text
            APIService.sharedInstance.requestSendRequest(email: email!, name: name!, mobile: mobile!, title: title!, content: content!, completion: { (success) in
                if success{
                    alter.message = self.languageManager.localizedString(string: "SendRequestSuccessfully")
                    self.view.endEditing(true)
                }
                else{
                    alter.title = self.languageManager.localizedString(string: "SendRequestFailed")
                    alter.message = "Thử lại!"
                }
                self.present(alter, animated: true, completion: {})
            })
            
        }else{
            //show mes
            alter.title = "Thông tin nhập chưa đủ"
            alter.message = validateMes
            self.present(alter, animated: true, completion: {})
        }
    }
    
    func validate()->String?{
        return validateUserName()
    }
    
    func validateUserName()->String?{
        if (inputNameView.textField.text?.trimmingCharacters(in: CharacterSet.whitespaces).characters.count)! < 1 {
            inputNameView.textField.becomeFirstResponder()
            return "Vui lòng nhập tên"
        }
        
        return validateEmail()
    }
    func validateEmail()-> String?{
        

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: inputEmailView.textField.text){
            return validatePhone()
        }
        return "Sai định dạng email"
    }
    func validatePhone()-> String?{
        let mobileFormat = "^\\d{10,11}$"
        
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileFormat)
        if mobileTest.evaluate(with: inputMobileView.textField.text){
            inputMobileView.becomeFirstResponder()
            return validateTitle()
        }
        return "Số điện thoại chưa đúng"
    }
    func validateTitle()->String?{
        
        if (inputTitleView.textField.text?.trimmingCharacters(in: CharacterSet.whitespaces).characters.count)! < 1 {
            inputTitleView.textField.becomeFirstResponder()
            return "Vui lòng nhập tiêu đề"
        }
        
        return validateContent()
    }
    func validateContent() -> String? {
        if (contentTextView.text?.trimmingCharacters(in: CharacterSet.whitespaces).characters.count)! < 50 {
            contentTextView.becomeFirstResponder()
            return "Vui lòng nhập nội dung tối thiểu 50 ký tự"
        }
        
        return nil
    }
    
    
    override func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
        }
    }
}
