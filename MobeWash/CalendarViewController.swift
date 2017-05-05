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
    let availability = ["May": [5: [10, 11, 12], 7: [8, 14]]]
    
    var noneAvailable = false
    var selectedMonth = String()
    var selectedDate = Int()
    var displayDate = String()
    var selectedTime = String()
    
    
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var noTimesLabel: UILabel!
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var month: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        
        self.setDateVariables(selectedDateAndTime: Date())
        timeTableView.cellLayoutMarginsFollowReadableWidth = false
        
        timeTableView.tableFooterView = UIView(frame: CGRect.zero)
        noTimesLabel.font = noTimesLabel.font.withSize(20)
        noTimesLabel.textColor = UIColor.gray
        noTimesLabel.isHidden = true
    }
    
    func setupCalendarView(){
        // Set up calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.selectDates([Date()])
        
        // Set up labels
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }

    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
      
        self.formatter.dateFormat = "MMMM"
        self.month.text = formatter.string(from: date)
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
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarCell else { return }
        if validCell.isSelected{
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    let brightBlue = UIColor(red: 116/255.0, green: 218/255.0, blue: 1, alpha: 1.0)
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarCell else { return }
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = brightBlue
            } else {
                validCell.dateLabel.textColor = UIColor.lightGray
            }
        }
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
        
        let month = Calendar.current.component(.month, from: Date())
        let start = formatter.date(from: "2017 " + String(month) + " 01")!
        let end = formatter.date(from: "2017 12 31")!
        calendar.allowsMultipleSelection = false
        
        let parameters = ConfigurationParameters(startDate: start, endDate: end)
        return parameters
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell

        /*let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "-----")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 3, range: NSMakeRange(0, attributeString.length))
        
        let badDates : Set = ["5","9","10","11","20",] */
        
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        /*if cell.dateLabel.text == "12" || badDates.contains(cell.dateLabel.text!){
            cell.strikeThrough.attributedText = attributeString
        }
        //cell.strikeThrough.attributedText = attributeString
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        
        if cell.isSelected {
            cell.isHighlighted = false
        } */
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        self.setDateVariables(selectedDateAndTime: date)
        timeTableView.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
}
