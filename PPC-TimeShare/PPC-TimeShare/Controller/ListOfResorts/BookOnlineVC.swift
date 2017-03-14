//
//  BookOnlineVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BookOnlineVC: BookInAdvanceVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Book online"
    }

    let inputNameView : InputView = {
        let input = InputView()
        input.iconName = "name_icon"
        input.hint = "Name"
        
        return input
    }()
    let inputEmailView : InputView = {
        let input = InputView()
        input.hint = "Email"
        input.iconName = "your_email_icon"
        return input
    }()
    let inputMobileView : InputView = {
        let input = InputView()
        input.hint = "Mobile number"
        input.iconName = "mobile_number_icon"
        return input
    }()
    let inputAddressView : InputView = {
        let input = InputView()
        input.hint = "Address"
        input.iconName = "adress_icon_1"
        return input
    }()
    override func setupInfoRequestView() {
        
        inputNameView.topAnchor.constraint(equalTo: self.priceIcon.bottomAnchor, constant: 5).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputNameView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputEmailView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputMobileView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: inputAddressView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: checkInView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: checkOutView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: roomView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: TravelersView)
        
        view.addConstraintWithFormat(format: "V:[v0(\(itemHeight!))]-\(spaceLine)-[v1(\(itemHeight!))]-\(spaceLine)-[v2(\(itemHeight!))]-\(spaceLine)-[v3(\(itemHeight!))]-\(spaceLine)-[v4(\(itemHeight!))]-\(spaceLine)-[v5(\(itemHeight!))]-\(spaceLine)-[v6(\(itemHeight!))]-\(spaceLine)-[v7(\(itemHeight!))]", views: inputNameView, inputEmailView, inputMobileView, inputAddressView, checkInView, checkOutView, roomView, TravelersView)
    }
    
    override func handleBook() {
        print("Book online")
    }
    override func addSubView() {
        super.addSubView()
        view.addSubview(inputNameView)
        view.addSubview(inputEmailView)
        view.addSubview(inputMobileView)
        view.addSubview(inputAddressView)
    }


}
