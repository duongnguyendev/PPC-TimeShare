//
//  SpecialOffersDetailVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/16/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SpecialOffersDetailVC: BaseViewController {
    
    var offer : Offer?{
        didSet{
            self.imagePoster.loadImageUsingUrlString(urlString: (offer?.imageUrlString)!)
            self.webViewContent.loadHTMLString((offer?.content)!, baseURL: nil)
            
            let size = CGSize(width: view.frame.width - 30, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedRect = NSString(string: (offer?.title)!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.init(name: "Roboto-Medium", size: 16)!], context: nil)
            textViewHeight?.constant = estimatedRect.height + 20
            self.textViewTitle.text = offer?.title
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LanguageManager.sharedInstance.localizedString(string: "SpecialOffers")
        
    }
    
    let imagePoster : CustomImageView = {
        let imageView = CustomImageView(image: UIImage(named: "resort"))
        return imageView
    }()
    
    let textViewTitle : UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Roboto-Medium", size: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let webViewContent : UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = UIColor.clear
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isOpaque = false
        return webView
    }()
    
    var textViewHeight : NSLayoutConstraint?
    
    override func setupView() {
        
        view.addSubview(imagePoster)
        view.addSubview(webViewContent)
        view.addSubview(textViewTitle)
        imagePoster.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: imagePoster)
        let imageHeight = view.frame.size.width / 16 * 9
        imagePoster.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        textViewTitle.topAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant: 10).isActive = true
        textViewTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textViewTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        textViewHeight = NSLayoutConstraint(item: textViewTitle, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 20)
        
        view.addConstraint(textViewHeight!)
        
        webViewContent.topAnchor.constraint(equalTo: textViewTitle.bottomAnchor, constant: 0).isActive = true
        webViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: webViewContent)
        
        
    }
}
