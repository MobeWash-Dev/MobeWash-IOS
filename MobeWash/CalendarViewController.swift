//
//  CalendarViewController.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/3/17.
//
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let formatter = DateFormatter()
    
    // Dummy Data
    let availability = ["May": [4: [10, 11, 12], 7: [8, 14]]]
    
    var noneAvailable = false
    var selectedMonth = String()
    var selectedDate = Int()
    var displayDate = String()
    var selectedTime = String()
    
    
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var noTimesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDateVariables(selectedDateAndTime: Date())
        timeTableView.cellLayoutMarginsFollowReadableWidth = false
        
        timeTableView.tableFooterView = UIView(frame: CGRect.zero)
        noTimesLabel.font = noTimesLabel.font.withSize(20)
        noTimesLabel.textColor = UIColor.gray
        noTimesLabel.isHidden = true
    }
    
    func setDateVariables(selectedDateAndTime: Date){
        let dateAndTime = selectedDateAndTime
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        
        // ["Month Date", "Year", "Time"]
        let dateTimeArray = formatter.string(from: dateAndTime).components(separatedBy: ",")
        
        // ["Month", "Date"]
        let dateArray = dateTimeArray[0].components(separatedBy: " ")
        
        selectedMonth = dateArray[0]
        selectedDate = Int(dateArray[1])!
        displayDate = dateTimeArray[0]
        
        // Data Source to be changed
        if availability[selectedMonth]?[selectedDate]?.isEmpty == nil{
            noneAvailable = true
            noTimesLabel.isHidden = false
            timeTableView.isHidden = true
        } else{
            noneAvailable = false
            noTimesLabel.isHidden = true
            timeTableView.isHidden = false
        }
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noneAvailable == true{
            return 0
        }
        
        // Data source to be changed
        return availability[selectedMonth]![selectedDate]!.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "timeCell")
        
        if noneAvailable == true{
            return cell
        }
        
        // Data source to be changed
        let time = availability[selectedMonth]![selectedDate]![indexPath.row]
        // Selecting AM and PM to be changed
        if(time < 13){
            cell.textLabel?.text = String(time)+"AM"
        } else{
            cell.textLabel?.text = String(time-12)+"PM"
        }
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.layer.borderColor = UIColor.gray.cgColor
        selectedTime = (currentCell?.textLabel!.text)!
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
