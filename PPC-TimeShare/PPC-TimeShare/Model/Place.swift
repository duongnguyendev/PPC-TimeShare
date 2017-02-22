//
//  Country.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Country: NSObject {

    var countryId : String?
    var countryName : String?
    init(countryId : String, countryName: String) {
        self.countryId = countryId
        self.countryName = countryName
    }
}

class Province: NSObject {
    var provinceId : String?
    var provinceName : String?
    init(provinceId : String, provinceName: String) {
        self.provinceId = provinceId
        self.provinceName = provinceName
    }
}
