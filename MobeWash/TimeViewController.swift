//
//  TimeViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 4/28/17.
//
//

import UIKit
import FSCalendar

class TimeViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    // Dummy Data
    @IBOutlet weak var calendar: FSCalendar!
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let today = ["2017/05/02": UIColor.green]
    
    
    let fillAvailableColors = ["2017/05/03": UIColor.blue, "2017/05/04": UIColor.blue,"2017/05/07": UIColor.blue]
    
    //let fillUnAvailableColors = ["2017/05/05": UIColor.red, "2017/05/06": UIColor.red,"2017/05/08": UIColor.red]
    
    let unAvailableColors = ["2017/05/05": UIColor.red, "2017/05/06": UIColor.red,"2017/05/08": UIColor.red]
    
    let borderSelectionColors = ["2017/05/05": UIColor.green, "2017/05/06": UIColor.green,"2017/05/08": UIColor.green]
    
    var datesWithAvailableWashers = ["2017/05/03", "2017/05/04", "2017/05/07"]
    var datesWithUnAvailableWashers = ["2017/05/05", "2017/05/06", "2017/05/08"]
    
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
        let calendar = FSCalendar(frame: CGRect(x:0, y:64, width:self.view.bounds.size.width, height:height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = false
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.backgroundColor = UIColor.white
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        self.view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.select(Date())
        //calendar.select(self.dateFormatter1.date(from: "2017/05/02"))
        /*let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem*/
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        self.calendar.today = nil
    }
    
    deinit {
        print("\(#function)")
    }
    
    /*@objc
    func todayItemClicked(sender: AnyObject) {
        self.calendar.setCurrentPage(Date(), animated: false)
    } */
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter1.string(from: date)
        if self.datesWithAvailableWashers.contains(dateString) {
            return 1
        }
        if self.datesWithUnAvailableWashers.contains(dateString) {
            return 3
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date) -> Bool {
        let dateString = self.dateFormatter1.string(from: date)
        if self.datesWithUnAvailableWashers.contains(dateString) {
            return false
        }
        
        let year = Calendar.current.component(.year, from:Date())
        let month = Calendar.current.component(.month, from:Date())
        let day = Calendar.current.component(.day, from:Date())
        if (date < self.dateFormatter1.date(from: String(year)+"/"+String(month)+"/"+String(day))!){
            return false
        }
        
        return true
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter1.string(from: date)
        if self.datesWithAvailableWashers.contains(dateString) {
            return UIColor.purple
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter1.string(from: date)
        if self.datesWithUnAvailableWashers.contains(key) {
            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.fillAvailableColors[key] {
            return color
        }
        return appearance.selectionColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.unAvailableColors[key] {
            return color
        }
        return nil
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if let color = self.today[key] {
//            return color
//        }
//        return appearance.borderDefaultColor
//    }
//    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if let color = self.borderSelectionColors[key] {
//            return color
//        }
//        return appearance.borderSelectionColor
//    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
//        let key = self.dateFormatter2.string(from: date)
//        if datesWithUnAvailableWashers.contains(key) {
//            return 0.0
//        }
//        return 1.0
//    }
}
