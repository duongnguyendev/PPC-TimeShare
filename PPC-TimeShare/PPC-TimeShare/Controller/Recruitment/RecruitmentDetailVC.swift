//
//  RecruitmentDetailVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class RecruitmentDetailVC: BaseViewController{
    var recruitment: Recruitment?{
        didSet{
            if let imageUrl = recruitment?.image{
                self.imageView.loadImageUsingUrlString(urlString: (imageUrl))
            }
            self.labelTitle.text = recruitment?.title
            self.labelDate.text = recruitment?.date
            self.webViewContent.loadHTMLString((recruitment?.content)!, baseURL: nil)
            
        }
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView(image : UIImage(named: "no_image_icon"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    let labelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
    let labelDate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Roboto-Light", size: 14)
        return label
    }()
    
    let webViewContent : UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        view.addSubview(imageView)
        view.addSubview(labelTitle)
        view.addSubview(labelDate)
        view.addSubview(webViewContent)
        
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width / 16 * 9).isActive = true
        self.view.addConstraintWithFormat(format: "H:|[v0]|", views: imageView)
        
        labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        
        self.view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelTitle)
        self.view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelDate)
        self.view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webViewContent)
        
        self.view.addConstraintWithFormat(format: "V:[v0(20)][v1(20)][v2]|", views:labelTitle, labelDate, webViewContent)
        
    }
    
    override func localizeString() {
        title = languageManager.localizedString(string: "Recruitment")
    }

}
