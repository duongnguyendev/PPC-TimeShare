//
//  ShareAppVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/6/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ShareAppVC: BaseViewController {

    var user : User?{
        didSet{
            codeLable.text = user?.shareCode
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = languageManager.localizedString(string: "Share")
        // Do any additional setup after loading the view.
    }

    let textViewContent : UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.textAlignment = .justified
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont(name: "Roboto-Light", size: 16)
        tv.text = LanguageManager.sharedInstance.localizedString(string: "ShareAppContent")
        return tv
    }()
    let buttonShare : MyButton = {
        let button  = MyButton()
        button.backgroundColor = UIColor.button1Collor()
        button.setTitle(LanguageManager.sharedInstance.localizedString(string: "Share"), for: .normal)
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return button
    }()
    let codeLable : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    override func setupView() {
        view.addSubview(textViewContent)
        view.addSubview(codeLable)
        view.addSubview(buttonShare)
        
        view.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: textViewContent)
        view.addConstraintWithFormat(format: "H:|-100-[v0]-100-|", views: codeLable)
        view.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: buttonShare)
        view.addConstraintWithFormat(format: "V:|-15-[v0]-20-[v1(40)]-20-[v2(40)]-20-|", views: textViewContent, codeLable, buttonShare)
    }
    
    func handleShare(){
        let shareAppContent = languageManager.localizedString(string: "ShareAppContent")
        let PromotionalCode = languageManager.localizedString(string: "PromotionalCode")
        
        let text = "\(shareAppContent!)\n\(PromotionalCode!)\((user?.shareCode)!)"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
