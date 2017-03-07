//
//  DropDownLanguages.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Language: NSObject {
    var language : String?
    var languageCode : String?
    
    init(languageCode: String, language: String) {
        self.languageCode = languageCode
        self.language = language
    }
}

class DropDownLanguages: DropDownView {
    
    override func setupView() {
        super.setupView()
        collectionView.register(LanguageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    let lisLanguages : [Language] = {
        let en = Language(languageCode: "en", language: "English")
        let vi = Language(languageCode: "vi", language: "Vietnamese")
        return [en, vi]
    }()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lisLanguages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LanguageCell
        cell.labelString.text = lisLanguages[indexPath.item].language
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selected!(language: lisLanguages[indexPath.row])
        hide()
    }
}

class LanguageCell: DropDownCell {
    override func setupView() {
        super.setupView()
        self.labelString.textAlignment = .right
    }
}
