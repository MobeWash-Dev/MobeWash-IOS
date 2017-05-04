//
//  CalendarViewController.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/3/17.
//
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let start = formatter.date(from: "2017 01 01")!
        let end = formatter.date(from: "2017 12 31")!
        calendar.allowsMultipleSelection = true
        
        let parameters = ConfigurationParameters(startDate: start, endDate: end)
        return parameters
    }
    
    
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "-----")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 3, range: NSMakeRange(0, attributeString.length))
        
        let badDates : Set = ["5","9","10","11","20",]
        
        cell.dateLabel.text = cellState.text
        if cell.dateLabel.text == "12" || badDates.contains(cell.dateLabel.text!){
            cell.strikeThrough.attributedText = attributeString
        }
        //cell.strikeThrough.attributedText = attributeString
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        
        if cell.isSelected {
            cell.isHighlighted = false
        }
        
        
        return cell
    }
    
}
