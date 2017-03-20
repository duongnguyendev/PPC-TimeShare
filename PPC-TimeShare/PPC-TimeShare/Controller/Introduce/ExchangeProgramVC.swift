//
//  ExchangeProgramVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 3/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ExchangeProgramVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = languageManager.localizedString(string: "ExchangeProgram")
        collectionExchange.register(ExchangeProgramCell.self, forCellWithReuseIdentifier: cellId)
        // Do any additional setup after loading the view.
    }
    let cellId = "cellId"
    
    lazy var collectionExchange : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true

        return cv
        
    }()
    override func setupView() {
        view.addSubview(collectionExchange)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionExchange)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionExchange)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExchangeProgramCell
        cell.exchageType = indexPath.item
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
class ExchangeProgramCell: BaseCell {
    
    var exchageType : Int?{
        didSet{
            if let type = exchageType {
                switch type {
                case 0: // DEPOSITING FOR PPC
                    handleDepositing()
                    break
                case 1: // HELPING YOUR VACATION EXCHANGE
                    handleHelpingVacationExchange()
                    break
                    
                case 2: // VACATION EXCHANGE CONFIRMATION
                    handleVacationExchangeConfirm()
                    break
                default:
                    break
                }
            }
        }
    }
    let iconExchange : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let labelExchange : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appStyleColor()
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.numberOfLines = 2
        return label
    }()
    let textViewExchange : UITextView = {
        let tv = UITextView()
        tv.textAlignment = .justified
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont(name: "Roboto-Light", size: 16)
        tv.textColor = UIColor.appStyleColor()
        return tv
    }()
    
    override func setupView() {
        addSubview(iconExchange)
        addSubview(labelExchange)
        addSubview(textViewExchange)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: iconExchange)
        addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelExchange)
        addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: textViewExchange)
        
        addConstraintWithFormat(format: "V:|-40-[v0(60)]-30-[v1(50)]-25-[v2]|", views: iconExchange, labelExchange, textViewExchange)
    }
    
    func handleDepositing(){
        self.iconExchange.image = UIImage(named: "depositing")
        self.labelExchange.text = LanguageManager.sharedInstance.localizedString(string: "DEPOSITINGFORPPC")
        self.textViewExchange.text = LanguageManager.sharedInstance.localizedString(string: "DEPOSITINGFORPPCContent")
    }
    func handleHelpingVacationExchange(){
        self.iconExchange.image = UIImage(named: "vacation_exchange")
        self.labelExchange.text = LanguageManager.sharedInstance.localizedString(string: "HELPINGYOURVACATIONEXCHANGE")
        self.textViewExchange.text = LanguageManager.sharedInstance.localizedString(string: "DEPOSITINGFORPPCContent")
    }
    func handleVacationExchangeConfirm(){
        self.iconExchange.image = UIImage(named: "vacation_exchange_confirmtion")
        self.labelExchange.text = LanguageManager.sharedInstance.localizedString(string: "VACATIONEXCHANGECONFIRMATION")
        self.textViewExchange.text = LanguageManager.sharedInstance.localizedString(string: "DEPOSITINGFORPPCContent")
    }
}

