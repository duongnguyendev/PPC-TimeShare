//
//  PromotionVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SpecialOffersVC: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var offers : [Offer]?
    
    func fetchOffers(){
        self.activity.startAnimating()
        APIService.sharedInstance.requestGetOffers { (offers, errorMes) in
            self.activity.stopAnimating()
            if errorMes != nil{
                //show mes
            }else{
                self.offers = offers
                self.collectionOffers.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LanguageManager.sharedInstance.localizedString(string: "SpecialOffers")
        collectionOffers.register(SpecialOffersCell.self, forCellWithReuseIdentifier: cellId)
        fetchOffers()

    }
    override func setupView() {
        super.setupView()
        setupBackGround()
        setupCollectionView()
        
    }
    
    let cellId = "cellId"
    
    lazy var collectionOffers : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let textFielCode : UITextField = {
        let textFiel = UITextField()
        textFiel.font = UIFont(name: "Roboto-Light", size: 17)
        textFiel.placeholder = LanguageManager.sharedInstance.localizedString(string: "EnterASpecialOfferCode")
        return textFiel
    }()
    let butttonAddCode : MyButton = {
        let button = MyButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = UIColor.button1Collor()
        button.addTarget(self, action: #selector(handleAddcode), for: .touchUpInside)
        return button
    }()
    
    // set up view
    
    func setupCollectionView(){
        view.addSubview(collectionOffers)
        let inputCodeView = UIView()
        inputCodeView.translatesAutoresizingMaskIntoConstraints = false
        inputCodeView.backgroundColor = UIColor.white
        view.addSubview(inputCodeView)
        view.addConstraintWithFormat(format: "H:|-25-[v0]-25-|", views: inputCodeView)

        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionOffers)
        view.addConstraintWithFormat(format: "V:|-10-[v0(50)]-20-[v1]|", views:inputCodeView, collectionOffers)
        
        inputCodeView.addSubview(textFielCode)
        inputCodeView.addSubview(butttonAddCode)
        
        inputCodeView.addConstraintWithFormat(format: "V:|[v0]|", views: textFielCode)
        inputCodeView.addConstraintWithFormat(format: "V:|[v0]|", views: butttonAddCode)
        inputCodeView.addConstraintWithFormat(format: "H:|-10-[v0][v1(50)]|", views: textFielCode, butttonAddCode)
    }
    
    func setupBackGround(){
        let redView : UIView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        redView.backgroundColor = UIColor.appStyleColor()
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        redView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        
    }
    
    // collection delegate - datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let imageheight = (view.frame.width) / 16 * 9
        
        let size = CGSize(width: view.frame.width - 50 - 20, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedRect = NSString(string: (offers?[indexPath.item].title)!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 13)], context: nil)
        
        return CGSize(width: view.frame.size.width, height: imageheight + estimatedRect.height + 45)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SpecialOffersCell
        cell.offer = offers?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC : SpecialOffersDetailVC = SpecialOffersDetailVC()
        pushVC(viewController: detailVC)
        detailVC.offer = offers?[indexPath.item]
    }
    
    func handleAddcode(){
        let currentUserInfo = UserDefaults.standard.value(forKey: "currentUser")
        
        if currentUserInfo != nil {
            let user = User(data: currentUserInfo as! Dictionary <String, Any>)
            if (textFielCode.text?.trimmingCharacters(in: CharacterSet.whitespaces).characters.count)! > 6 {
                APIService.sharedInstance.requestAddShareCode(id: user.userId!, code: self.textFielCode.text!, completion: { (errorMes) in
                    if errorMes != nil{
                        self.showMes(mes: errorMes!)
                    }else{
                        self.showMes(mes: self.languageManager.localizedString(string: "TheCodeHasBeenSentSuccessfully")!)
                    }
                })
            }else{
                self.showMes(mes: self.languageManager.localizedString(string: "PromotionalCodeIsNotCorrect")!)
            }
            
            
        }else{
            let singInVC : SignInVC = SignInVC()
            presentVC(viewController: singInVC)
        }
    }
    override func hideKeyboarTouchupOutSide() {
        
    }
    
    func showMes(mes: String) {
        self.view.endEditing(true)
        let alert  = UIAlertController(title: "", message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            
        }))
        self.present(alert, animated: true) { 
            
        }
    }
}
