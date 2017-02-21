//
//  UserProfileVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class UserProfileVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
    }
    override func setupNavBar() {
        super.setupNavBar()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func setupView() {
        super.setupView()
    }
}
