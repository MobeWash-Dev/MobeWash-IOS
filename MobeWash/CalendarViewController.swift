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
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var noTimesLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var bookingData:Booking?
    var selectedDateTime:String?
    
    let brightBlue: UIColor = UIColor(red: 32/255.0, green: 139/255.0, blue: 1, alpha: 1.0)
    let formatter = DateFormatter()
    
    var selectedMonth: String?
    var selectedDate: Int?
    var displayDate: String?
    var selectedTime: String?
    var noneAvailable: Bool = false

    // Dummy Data
    let availability = ["June": [5: [10, 11, 12], 7: [8, 14]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO - Api call for slot times to calculated available times 
        
        setupCalendarView()
        
        self.setDateVariables(selectedDateAndTime: Date())
        
        timeTableView.cellLayoutMarginsFollowReadableWidth = false
        timeTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        noTimesLabel.font = noTimesLabel.font.withSize(20)
        noTimesLabel.textColor = UIColor.gray
        noTimesLabel.isHidden = true
    }
    
    func setupCalendarView(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.selectDates([Date()])
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }

    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
      
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = formatter.string(from: date)
    }

    func setDateVariables(selectedDateAndTime: Date){
        let dateAndTime = selectedDateAndTime
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        
        // ["Month Date", "Year", "Time"]
        let dateTimeArray: [String] = formatter.string(from: dateAndTime).components(separatedBy: ",")
        
        // ["Month", "Date"]
        let dateArray: [String] = dateTimeArray[0].components(separatedBy: " ")
        
        selectedMonth = dateArray[0]
        selectedDate = Int(dateArray[1])!
        displayDate = dateTimeArray[0]
        
        // Data Source to be changed
        if availability[selectedMonth!]?[selectedDate!]?.isEmpty == nil{
            noneAvailable = true
            noTimesLabel.isHidden = false
            timeTableView.isHidden = true
        } else{
            noneAvailable = false
            noTimesLabel.isHidden = true
            timeTableView.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK -- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Dummy Data
        bookingData?.datetime = "DateTime"
        
        if let destinationViewController = segue.destination as? UserDetailsViewController{
            destinationViewController.bookingData = self.bookingData
        }
        
    }
    
    
    
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noneAvailable == true{
            return 0
        }
        
        return availability[selectedMonth!]![selectedDate!]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "timeCell")
        
        if noneAvailable == true{
            return cell
        }
        
        // Data source to be changed
        let time = availability[selectedMonth!]![selectedDate!]![indexPath.row]
        
        // Selecting AM and PM to be changed
        if(time < 13){
            cell.textLabel?.text = String(time)+"AM"
        } else{
            cell.textLabel?.text = String(time-12)+"PM"
        }
        let view = UIView()
        view.backgroundColor = .blue
        cell.selectedBackgroundView = view
        return cell
    }
}

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let currentCell = tableView.cellForRow(at: indexPath)
        if (currentCell?.isSelected)! {
            currentCell?.selectionStyle = .blue
        } else {
            currentCell?.backgroundColor = UIColor.black
        }
        //currentCell?.layer.borderColor = UIColor.blue.cgColor
        //currentCell?.backgroundColor = UIColor.blue
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        //currentCell?.layer.borderColor = UIColor.blue.cgColor
        currentCell?.backgroundColor = UIColor.blue
        
        // Choose what to do with user's selected time
        selectedTime = (currentCell?.textLabel!.text)!
        
        performSegue(withIdentifier: "Details", sender: self)
        
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let month = Calendar.current.component(.month, from: Date())
        let year = Calendar.current.component(.year, from: Date())
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let start = formatter.date(from: String(year) + " " + String(month) + " 01")!
        let end = formatter.date(from: String(year+1) + " " + String(month) + " 30")!
        calendar.allowsMultipleSelection = false
        
        let parameters = ConfigurationParameters(startDate: start, endDate: end)
        return parameters
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarJTAppleCell", for: indexPath) as! CalendarJTAppleCell

        // Blocking out dates
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "-----")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 3, range: NSMakeRange(0, attributeString.length))
        
        let badDates : Set = ["9","10","11","20"]
        let cellMonth = Calendar.current.component(.month, from: date)
        let cellDay = Calendar.current.component(.day, from: date)
        
        cell.dateLabel.text = cellState.text
        
        if (String(cellMonth) == "5" && badDates.contains(cell.dateLabel.text!)){
            cell.strikeThrough.attributedText = attributeString
            cell.isUserInteractionEnabled = false
        } else {
            cell.strikeThrough.text = ""
            cell.isUserInteractionEnabled = true
        }
        
        // Getting current date
        let currMonth = Calendar.current.component(.month, from: Date())
        let currDate = Calendar.current.component(.day, from: Date())
        
        if currMonth == cellMonth && currDate == cellDay {
            cell.isCurrentDate = true
        } else {
            cell.isCurrentDate = false
        }
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
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
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell, cellState: CellState) -> Bool {
        if cellState.dateBelongsTo == .thisMonth {
            return true
        } else {
            return false
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarJTAppleCell else { return }
        
        if cellState.isSelected{
            validCell.selectedView.backgroundColor = brightBlue
            validCell.selectedView.isHidden = false
        } else if validCell.isCurrentDate {
            validCell.selectedView.backgroundColor = UIColor.lightGray
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarJTAppleCell else { return }
        
        if cellState.isSelected || validCell.isCurrentDate {
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.black
            } else {
                validCell.dateLabel.textColor = UIColor.lightGray
            }
            
        }
    }
}
