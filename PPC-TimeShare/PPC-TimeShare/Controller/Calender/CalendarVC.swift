//
//  CalendarVC.swift
//  PPC-TimeShare
//
//  Created by Nguyen Duy Duong on 4/24/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import EPCalendarPicker

class CalendarVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CalendarCellDelegate, InputLauncherDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.sharedInstance.localizedString(string: "Calendar")
        collectionWeek.register(CalendarCell.self, forCellWithReuseIdentifier: cellId)
        self.getWeekOfYear(year: Date().year)
    }
    let cellId = "cellId"
    var weeks : [Week]? {
        didSet{
            self.collectionWeek.reloadData()
        }
    }
    
    let yearButton : InfoButton = {
        let v = InfoButton()
        v.addTarget(self, action: #selector(handleYearButton), for: .touchUpInside)
        v.title = LanguageManager.sharedInstance.localizedString(string: "Year")
        v.iconName = "icon_calendar"
        v.value = "2017"
        return v
    }()
    lazy var collectionWeek : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    let yearLauncher = YearLauncher()
    
    override func setupView() {
        view.addSubview(yearButton)
        view.addSubview(collectionWeek)
        
        
        let labelWeek = createLabel(title: "Week")
        let labelFriday = createLabel(title: "Friday")
        let labelSaturday = createLabel(title: "Saturday")
        let labelSunday = createLabel(title: "Sunday")
        
        view.addSubview(labelWeek)
        view.addSubview(labelFriday)
        view.addSubview(labelSaturday)
        view.addSubview(labelSunday)
        
        labelWeek.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelFriday.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelSaturday.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelSunday.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addConstraint(NSLayoutConstraint(item: labelWeek, attribute: .width, relatedBy: .equal, toItem: labelFriday, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: labelWeek, attribute: .width, relatedBy: .equal, toItem: labelSaturday, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: labelWeek, attribute: .width, relatedBy: .equal, toItem: labelSunday, attribute: .width, multiplier: 1, constant: 0))
        
        view.addConstraintWithFormat(format: "H:|-1-[v0]-1-[v1]-1-[v2]-1-[v3]-1-|", views: labelWeek,labelFriday,labelSaturday,labelSunday)
        labelFriday.centerYAnchor.constraint(equalTo: labelWeek.centerYAnchor, constant: 0).isActive = true
        labelSaturday.centerYAnchor.constraint(equalTo: labelWeek.centerYAnchor, constant: 0).isActive = true
        labelSunday.centerYAnchor.constraint(equalTo: labelWeek.centerYAnchor, constant: 0).isActive = true
        
        view.addConstraintWithFormat(format: "V:|[v0(50)]-1-[v1(50)]-1-[v2]|", views: yearButton, labelWeek, collectionWeek)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: yearButton)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionWeek)
    }
    
    func handleYearButton(){
        
        yearLauncher.delegate = self
        yearLauncher.show()
    }
    
    func createLabel(title: String) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.text = title
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        return label
    }
    
    //MARK: - InputLauncherDelegate
    
    func selected(year: Int) {
        self.yearButton.value = "\(year)"
        getWeekOfYear(year: year)
    }
    
    
    //MARK: - collectionDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeks?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CalendarCell
        cell.weekNumber = indexPath.item + 1
        cell.weekItem = self.weeks?[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width,  height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func getWeekOfYear(year : Int){
        var weeks = [Week]()
        var date = Date(string: "\(year)-01-01", format: "YYYY-mm-dd")// get first day of year
        
        var week = Week()
        while (date.isIn(year: year)) {
            switch date.dayOfWeek {
            case Int(1): // Chủ nhật
                week.sunday = date
                weeks.append(week)
                break
            case Int(6): // thứ 6
                week = Week()
                week.friday = date
                if date.isEndDayOf(year: year){
                    weeks.append(week)
                }
                break
            case Int(7): // thứ 7
                week.saturday = date
                if date.isEndDayOf(year: year){
                    weeks.append(week)
                }
                break
            default:
                break
            }
            date = date.getNextDate()
        }
        self.weeks = weeks
    }
    
    //MARK: - CalendarCellDelegate
    
    func select(date: Date) {
        
        let calendarPicker = EPCalendarPicker(startYear: Date().year, endYear: Date().year + 31, multiSelection: true, selectedDates: date.getWeeks())
        calendarPicker.startDate = date
        calendarPicker.hightlightsToday = false
        calendarPicker.showsTodaysButton = false
        calendarPicker.hideDaysFromOtherMonth = true
        calendarPicker.tintColor = UIColor.orange
        
        calendarPicker.dayDisabledTintColor = UIColor.gray
        calendarPicker.title = languageManager.localizedString(string: "Calendar")
        
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        calendarPicker.navigationController?.navigationBar.isTranslucent = false
        calendarPicker.navigationController?.navigationBar.barTintColor = UIColor.appStyleColor()
        self.present(navigationController, animated: true) {
            calendarPicker.scrollToMonthForDate(date)
        }
    }
}

struct Week {
    var friday : Date?
    var saturday : Date?
    var sunday: Date?
}
