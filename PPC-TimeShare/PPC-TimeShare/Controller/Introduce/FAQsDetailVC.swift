//
//  FAQsDetailVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FAQsDetailVC: BaseViewController {

    var htmlContent : String?{
        didSet{
            webView.loadHTMLString(htmlContent!, baseURL: nil)
        }
    }
    
    let webView : UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = languageManager.localizedString(string: "FAQs")
    }

    override func setupView() {
        view.addSubview(webView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: webView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: webView)
    }
}
