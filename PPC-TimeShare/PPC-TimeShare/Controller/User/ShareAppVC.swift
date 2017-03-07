//
//  ShareAppVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ShareAppVC: BaseViewController {

    var user : User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    let textViewContent : UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.textAlignment = .justified
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont(name: "Roboto-Light", size: 14)
        return tv
    }()
    let buttonShare : MyButton = {
        let button  = MyButton()
        button.backgroundColor = UIColor.button1Collor()
        button.setTitle("Share", for: .normal)
        return button
    }()
    let codeLable : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
    override func localizeString() {
        title = "Share"
    }

}
