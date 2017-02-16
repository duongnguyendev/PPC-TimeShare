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
        webView.backgroundColor = UIColor.clear
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isOpaque = false
        return webView
    }()
    
    override func setupView() {
        view.addSubview(imagePoster)
        view.addSubview(webViewContent)
        
        imagePoster.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: imagePoster)
        let imageHeight = view.frame.size.width / 16 * 9
        imagePoster.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        webViewContent.topAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant: 0).isActive = true
        webViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webViewContent)
        
        
    }
}
