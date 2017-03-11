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
                    handleAboutUS()
                    break
                case EnumIntroduceName.WhatISTimeshare:
                    labelTitle.text = "What is Timeshare"
                    handleWhatIsTimeshare()
                    break
                case EnumIntroduceName.FAQs:
                    labelTitle.text = "FAQs"
                    break
                case EnumIntroduceName.PPCTimesharebusiness:
                    labelTitle.text = "PPC Timeshare business"
                    handlePPCTimesharebusiness()
                    break
                case EnumIntroduceName.Benefits:
                    labelTitle.text = LanguageManager.sharedInstance.localizedString(string: "Benefits")
                    handleBenefits()
                    break
                case EnumIntroduceName.ExchangeProgram:
                    labelTitle.text = "Exchange Program"
                    handleExchangeProgram()
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
        return webView
    }()
    override func setupView() {
        view.addSubview(labelTitle)
        view.addSubview(webViewIntroduction)
        
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelTitle)
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webViewIntroduction)
        view.addConstraintWithFormat(format: "V:|-10-[v0(30)][v1]-20-|", views: labelTitle, webViewIntroduction)
    }
    
    func handleAboutUS(){
        APIService.sharedInstance.getAboutUs { (data, errorMes) in
            if errorMes == nil{
                let content = data?["noidung_gioithieu"] as! String
                self.webViewIntroduction.loadHTMLString(content, baseURL: nil)
            }else{
            }
        }
    }
    func handleWhatIsTimeshare(){
        APIService.sharedInstance.getWhatIsTimeShare { (data, errorMes) in
            if errorMes == nil{
                let title1 = data?["title_about_1"] as! String
                let title2 = data?["title_about_2"] as! String
                let content1 = data?["content_about_1"] as! String
                let content2 = data?["content_about_2"] as! String
                
                let htmlString = "<strong>\(title1)</strong>\r\n\(content1)<strong>\(title2)</strong>\r\n\(content2)"
                self.webViewIntroduction.loadHTMLString(htmlString, baseURL: nil)
            }
        }
    }
    func handleBenefits(){
        APIService.sharedInstance.getBenefit { (data, errorMes) in
            if errorMes == nil{
                let content = data?["content"] as! String
                self.webViewIntroduction.loadHTMLString(content, baseURL: nil)
            }else{
            }

        }
    }
    func handlePPCTimesharebusiness(){
        //hardcode
    }
    func handleExchangeProgram(){
        //hardcode
    }
    
}
