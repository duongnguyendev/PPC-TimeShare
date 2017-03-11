//
//  FAQsCell.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FAQsCell: BaseCell {

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
        webView.scrollView.isScrollEnabled = false
        return webView
    }()
    let view = UIView()
    override func setupView() {
        self.backgroundColor = UIColor.white
        addSubview(webView)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webView)
        addConstraintWithFormat(format: "V:|[v0]|", views: webView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: view)
        addConstraintWithFormat(format: "V:|[v0]|", views: view)
        
    }

}
