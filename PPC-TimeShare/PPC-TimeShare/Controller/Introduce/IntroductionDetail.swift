//
//  IntroduceListVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class IntroductionDetail: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Introduction"
    }

    var introduce : EnumIntroduceName?{
        didSet{
            if let intro = introduce{
                switch intro {
                case EnumIntroduceName.AboutUs:
                    labelTitle.text = "About us"
                    break
                case EnumIntroduceName.WhatISTimeshare:
                    labelTitle.text = "What is Timeshare"
                    break
                case EnumIntroduceName.FAQs:
                    labelTitle.text = "FAQs"
                    break
                case EnumIntroduceName.PPCTimesharebusiness:
                    labelTitle.text = "PPC Timeshare business"
                    break
                case EnumIntroduceName.Benefits:
                    labelTitle.text = LanguageManager.sharedInstance.localizedString(string: "Benefits")
                    break
                case EnumIntroduceName.ExchangeProgram:
                    labelTitle.text = "Exchange Program"
                    break
                }
            }
        }
    }
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        return label
    }()
    let webViewIntroduction : UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.loadHTMLString("<p style=\"text-align:justify\"><span style=\"font-size:16px\"><strong>In addition, the PPC PPC assets established with the timeshare được hope is a bridge for customers and other investors participating in the field of timeshare, vacation exchange together, and flexibility in the use of resources Ownership production of each other not only in the Vietnam market in particular also in the US market đ&oacute;, Japan, South Korea, ...</strong></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><strong>Timeshare PPC services are provided additional housekeeping staff makes all the home comfort and peace of mind of coal in the exchange of other property before and after the holiday.</strong></span></p>\r\n", baseURL: nil)
//        let url = URL(string: "https://facebook.com")
//        let fbRequest = URLRequest(url: url!)
//        webView.loadRequest(fbRequest)
        return webView
    }()
    override func setupView() {
        view.addSubview(labelTitle)
        view.addSubview(webViewIntroduction)
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelTitle)
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webViewIntroduction)
        view.addConstraintWithFormat(format: "V:|-10-[v0(30)][v1]-20-|", views: labelTitle, webViewIntroduction)
    }
    
}
