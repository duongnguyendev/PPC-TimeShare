//
//  Extensions.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 2/9/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func rgbAlpha(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func appStyleColor() -> UIColor{
        return UIColor.rgb(red: 52, green: 34, blue: 19)
    }
    static func button1Collor() -> UIColor{
        return UIColor.rgb(red: 255, green: 0, blue: 47)
    }
    static func button2Collor() -> UIColor{
        return UIColor.rgb(red: 188, green: 215, blue: 0)
    }
    static func buttonOKCollor() -> UIColor{
        return UIColor.rgb(red: 255, green: 205, blue: 0)
    }
}

extension UIView{
    
    func addConstraintWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
            
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}


extension Date{
    func dateToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    func dayMonthToString() -> String{
        
        switch self.month {
        case 1:
            return "\(day) Jan"
        case 2:
            return "\(day) Feb"
        case 3:
            return "\(day) Mar"
        case 4:
            return "\(day) Apr"
        case 5:
            return "\(day) May"
        case 6:
            return "\(day) Jun"
        case 7:
            return "\(day) Jul"
        case 8:
            return "\(day) Aug"
        case 9:
            return "\(day) Sep"
        case 10:
            return "\(day) Oct"
        case 11:
            return "\(day) Nov"
        case 12:
            return "\(day) Dec"
        default:
            return ""
        }
    }
    
    init(string : String, format: String) {
        let formatter  = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: string)
        self = date!
    }
    func isEndDayOf(year : Int) -> Bool {
        let nextDate = self.getNextDate()
        if self.year < nextDate.year{
            return true
        }
        return false
    }
    func getWeeks() ->[Date]{
        var weeks = [Date]()
        for i in 0...7{
            weeks.append(Date(timeInterval: TimeInterval(60 * 60 * 24 * i), since: self))
        }
        
        return weeks
    }
    func isIn(year: Int) ->Bool{
        return self.year == year
    }
    func  getNextDate() -> Date {
        let nextDate = Date(timeInterval: 60 * 60 * 24, since: self)
        return nextDate
    }
    var day : Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let day = myCalendar.component(.day, from: self)
        return day
    }
    var year : Int{
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: self)
        return year
    }
    var month: Int{
        let myCalendar = Calendar(identifier: .gregorian)
        let month = myCalendar.component(.month, from: self)
        return month
    }
    var dayOfWeek: Int{
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        return weekDay
    }
    
    
}

extension UIImage{
    func resize(newWidth : CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView : UIImageView{
    
    var imageUrlString : String?
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            image = imageFromCache
            return
        }
        var mUrlString = urlString
        mUrlString = mUrlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        if let url = URL(string: mUrlString){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error!)
                }
                else{
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data!)
                        if self.imageUrlString == urlString{
                            self.image = imageToCache
                        }
                        if imageToCache != nil{
                            imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        }
                        else{
                            self.image = UIImage(named: "no_image_icon")
                        }
                    }
                }
                
    
            }).resume()
        }else{
            self.image = UIImage(named: "no_image_icon")
        }
    }
}




