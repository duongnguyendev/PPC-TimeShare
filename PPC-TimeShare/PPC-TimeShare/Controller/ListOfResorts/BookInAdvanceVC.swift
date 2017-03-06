//
//  BookInAdvance.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BookInAdvanceVC: BaseViewController, InputLauncherDelegate {
    
    let margin : CGFloat = 20
    let spaceLine : CGFloat = 1
    var itemHeight : CGFloat?
    var user : User?
    var numberAdults : Int = 0
    var numberChilds : Int = 0
    var numberRooms : Int = 0
    var voucherId : Int?
    var resort : Resort?{
        didSet{
            labelName.text = resort?.name
            labelPrice.text = resort?.price
            labelAddress.text = resort?.address
        }
    }
    
    override func viewDidLoad() {
        itemHeight = (view.frame.size.height - 80 - 35 - 40 - 64) / 8
        super.viewDidLoad()
        checkOutView.dateValue = Date()
        checkOutView.value = Date().dateToString()
        checkInView.dateValue = Date()
        checkInView.value = Date().dateToString()
        title = "Book in advance"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    
    let labelName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 13)
        label.text = "Name Resort"
        return label
    }()
    
    let addressIcon : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "adress_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let priceIcon : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "price_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let labelAddress : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "123 Holywood, Los Angerles, USA"
        label.textColor = UIColor.red
        return label
    }()
    let labelPrice : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "2000 USD"
        label.textColor = UIColor.red
        return label
    }()
    
    let checkInView : InfoButton = {
        let v = InfoButton()
        v.addTarget(self, action: #selector(handleCheckInButton), for: .touchUpInside)
        v.title = "Check in"
        v.iconName = "check_in_icon"
        return v
    }()
    let checkOutView : InfoButton = {
        let v = InfoButton()
        v.addTarget(self, action: #selector(handleCheckOutButton), for: .touchUpInside)
        v.title = "Check out"
        v.iconName = "check_out_icon"
        return v
    }()
    let roomView : InfoButton = {
        let v = InfoButton()
        v.iconName = "room_icon"
        v.title = "Room"
        v.value = "0"
        v.addTarget(self, action: #selector(handleRoomButton), for: .touchUpInside)
        return v
    }()
    let TravelersView : InfoButton = {
        let v = InfoButton()
        v.addTarget(self, action: #selector(handleTravelersButton), for: .touchUpInside)
        v.title = "Travelers"
        v.iconName = "travelers_icon"
        v.value = "0"
        return v
    }()
    let voucherView : InfoButton = {
        let v = InfoButton()
        v.iconName = "room_icon"
        v.title = "Select voucher"
        v.value = ""
        v.addTarget(self, action: #selector(handleVoucherButton), for: .touchUpInside)
        return v
    }()
    
    let bookButton : MyButton = {
        let button = MyButton()
        button.setTitle("Book now", for: .normal)
        button.addTarget(self, action: #selector(handleBook), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    let datePicker = DateTimeLauncher()
    let inputTravelersLauncher = InputTravelersLauncher()
    let inputNumberRoomsLauncher = InputRoomLauncher()
    let listVoucherLauncher = ListVoucherLauncher()
    
    let textViewNote : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Roboto-Light", size: 14)
        textView.text = "Note"
        return textView
    }()
    
    override func setupView() {
        addSubView()
        setupResortInfoView()
        setupInfoRequestView()
    }
    func addSubView(){
        
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
        
        mainContentView.addSubview(labelName)
        mainContentView.addSubview(addressIcon)
        mainContentView.addSubview(priceIcon)
        mainContentView.addSubview(labelAddress)
        mainContentView.addSubview(labelPrice)
        mainContentView.addSubview(bookButton)
        mainContentView.addSubview(checkInView)
        mainContentView.addSubview(checkOutView)
        mainContentView.addSubview(roomView)
        mainContentView.addSubview(voucherView)
        mainContentView.addSubview(TravelersView)
        mainContentView.addSubview(textViewNote)
        
    }
    
    
    func setupResortInfoView(){
        
        mainContentView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: labelName)
        
        mainContentView.addConstraintWithFormat(format: "H:|-\(margin)-[v0(20)]-\(5)-[v1]-\(margin)-|", views: addressIcon, labelAddress)
        
        labelAddress.centerYAnchor.constraint(equalTo: addressIcon.centerYAnchor, constant: 0).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "H:|-\(margin)-[v0(20)]-\(5)-[v1]-\(margin)-|", views: priceIcon, labelPrice)
        
        labelPrice.centerYAnchor.constraint(equalTo: priceIcon.centerYAnchor, constant: 0).isActive = true
        
        mainContentView.addConstraintWithFormat(format: "V:|-5-[v0(20)][v1(20)][v2(20)]", views: labelName,addressIcon, priceIcon)
    }
    func setupInfoRequestView(){
        
        let noteHeight = view.frame.size.height - 105 - 64 - ((spaceLine * 4) + (3 * margin) + (5 * itemHeight!))
        
        checkInView.topAnchor.constraint(equalTo: priceIcon.bottomAnchor, constant: 5).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: checkInView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: checkOutView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: roomView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: TravelersView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: voucherView)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: textViewNote)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: bookButton)
        
        textViewNote.bottomAnchor.constraint(equalTo: bookButton.topAnchor, constant: -margin).isActive = true
        
        view.addConstraintWithFormat(format: "V:[v0(\(itemHeight!))]-\(spaceLine)-[v1(\(itemHeight!))]-\(spaceLine)-[v2(\(itemHeight!))]-\(spaceLine)-[v3(\(itemHeight!))]-\(spaceLine)-[v4(\(itemHeight!))]-\(margin)-[v5(\(noteHeight))]-\(margin)-[v6(35)]-\(margin)-|", views: checkInView, checkOutView, roomView, TravelersView,voucherView,textViewNote, bookButton)
    }
    
    //handle key board
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
            let point = CGPoint(x: 0, y: mainScrollView.contentSize.height - keyboardSize.height - 200 )
            mainScrollView.setContentOffset(point, animated: true)
        }
    }
    
    //handle button
    
    func handleBook(){
        let bookInfo = BookInfo()
        bookInfo.resort = self.resort
        bookInfo.checkInDate = self.checkInView.value
        bookInfo.checkOutDate = self.checkOutView.value
        bookInfo.room = Int(self.roomView.value!)
        bookInfo.numberAdults = self.numberAdults
        bookInfo.numberChilds = self.numberChilds
        bookInfo.note = self.textViewNote.text
        
        if validate() != nil {
            let alert = UIAlertController(title: "Notification", message: validate()!, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            APIService.sharedInstance.requestBook(user: self.user!, info: bookInfo, voucherId: self.voucherId, completion: { (status, errorMes) in
                if errorMes != nil{
                    let alert = UIAlertController(title: "Notification", message: "Fail", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Notification", message: "Success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        
    }
    
    func validate() -> String?{
        
        return validateDate()
    }
    
    func validateDate() -> String? {
        let compareCheckInToNow = NSCalendar.current.compare(checkInView.dateValue!, to: Date(), toGranularity: .day)
        let compareCheckInToCheckOut = NSCalendar.current.compare(checkInView.dateValue!, to: checkOutView.dateValue!, toGranularity: .day)
        
        if  compareCheckInToNow == .orderedDescending || compareCheckInToCheckOut == .orderedDescending  {
            
            return "wrong date"
        }
        
        return validateRoom()
    }
    func validateRoom() -> String? {
        if self.numberRooms <= 0  {
            return "select number of Room"
        }
        
        return validateTravelers()
    }
    func validateTravelers() -> String? {
        
        if (numberChilds + numberAdults) <= 0 {
            return "select number of Travelers"
        }
        return nil
    }
    
    
    
    func handleCheckInButton(){
        datePicker.getDateFor(item: checkInView)
    }
    func handleCheckOutButton(){
        datePicker.getDateFor(item: checkOutView)
    }
    func handleRoomButton(){
        inputNumberRoomsLauncher.delegate = self
        inputNumberRoomsLauncher.show()
    }
    func handleTravelersButton(){
        
        inputTravelersLauncher.delegate = self
        inputTravelersLauncher.show()
        
    }
    func handleVoucherButton(){
        
        listVoucherLauncher.delegate = self
        listVoucherLauncher.show()
    }
    
    // input launcher delegate
    
    func getNumberTravelers(adults: Int, childs: Int) {
        self.numberAdults = adults
        self.numberChilds = childs
        self.TravelersView.value = String(adults + childs)
        self.textViewNote.becomeFirstResponder()
    }
    
    func getNumberRooms(rooms: Int) {
        self.numberRooms = rooms
        self.roomView.value = String(rooms)
        self.textViewNote.becomeFirstResponder()
    }
    func getVoucher(voucher: Voucher) {
        self.voucherId = Int(voucher.voucherId!)
        self.voucherView.value = voucher.name
        
    }
    
}
