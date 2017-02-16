//
//  SpecialOffersDetailVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/16/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SpecialOffersDetailVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Special Offers"

    }
    
    let imagePoster : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "resort"))
        return imageView
    }()

    let webViewContent : UIWebView = {
        let webView = UIWebView()
        
        return webView
    }()
    
    override func setupView() {
        view.addSubview(imagePoster)
        view.addSubview(webViewContent)
        
        
    }
}
