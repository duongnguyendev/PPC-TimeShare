//
//  HistoryLauncher.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HistoryLauncher: BaseLauncher {
    
    var bookInfo : BookInfo?{
        didSet{
            self.labelTitle.text = bookInfo?.resort?.name
            self.checkInView.value = bookInfo?.checkInDate
            self.checkOutView.value = bookInfo?.checkOutDate
            self.roomView.value = "\((bookInfo?.room)!)"
            self.travelersView.value = "\((bookInfo?.numberAdults)! + (bookInfo?.numberAdults)!)"
            self.voucherView.value = bookInfo?.discount
            self.statusView.value = bookInfo?.status
        }
    }

    let labelTitle : UILabel = {
        let lable = UILabel()
        lable.text = "Resort name"
        lable.textAlignment = .center
        lable.font = UIFont(name: "Roboto-Medium", size: 14)
        lable.backgroundColor = UIColor.button1Collor()
        lable.textColor = UIColor.white
        return lable
    }()
    let checkInView : InfoButton = {
        let v = InfoButton()
        v.title = "Check in"
        v.iconName = "check_in_icon"
        return v
    }()
    let checkOutView : InfoButton = {
        let v = InfoButton()
        v.title = "Check out"
        v.iconName = "check_out_icon"
        return v
    }()
    let roomView : InfoButton = {
        let v = InfoButton()
        v.title = "Room"
        v.iconName = "room_icon"
        return v
    }()
    let travelersView : InfoButton = {
        let v = InfoButton()
        v.title = "Travelers"
        v.iconName = "travelers_icon"
        return v
    }()
    let voucherView : InfoButton = {
        let v = InfoButton()
        v.title = "Voucher"
        v.iconName = "icon_gift"
        return v
    }()
    let statusView : InfoButton = {
        let v = InfoButton()
        v.title = "Status"
        v.iconName = "icon_status"
        return v
    }()
    
    
    
    override func setupContent() {
        super.setupContent()
        self.touchUpOutSize()
        self.contentView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 345).isActive = true
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(checkInView)
        contentView.addSubview(checkOutView)
        contentView.addSubview(roomView)
        contentView.addSubview(travelersView)
        contentView.addSubview(voucherView)
        contentView.addSubview(statusView)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: labelTitle)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]", views: checkInView)
        checkInView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 50).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]", views: checkOutView)
        checkOutView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 50).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]", views: roomView)
        roomView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 50).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]", views: travelersView)
        travelersView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 50).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]", views: voucherView)
        voucherView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 50).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]", views: statusView)
        statusView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 50).isActive = true
        
        contentView.addConstraintWithFormat(format: "V:|[v0(40)][v1(50)]-1-[v2(50)]-1-[v3(50)]-1-[v4(50)]-1-[v5(50)]-1-[v6(50)]|", views: labelTitle, checkInView, checkOutView, roomView, travelersView, voucherView, statusView)
        
    }
}
