//
//  TimeViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 4/28/17.
//
//

import UIKit

class TimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Dummy Data
    let availability = ["April": [30: [10, 11, 12]],"May": [01: [10, 11, 12]]]
    
    var noneAvailable = false
    var selectedMonth = String()
    var selectedDate = Int()
    var displayDate = String()
    var selectedTime = String()
    
    var picker: UIDatePicker = UIDatePicker()
    
    @IBAction func selectDate(_ sender: UIButton) {
        picker.datePickerMode = UIDatePickerMode.date
        picker.addTarget(self, action:  #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        
        let screen = UIScreen.main.bounds
        picker.frame = CGRect(x:0.0, y:300, width:screen.size.width, height:250)
        picker.backgroundColor = UIColor.white
        
        
        var components = DateComponents()
        components.month = 1
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        picker.maximumDate = maxDate
        picker.minimumDate = Date()
        
        self.view.addSubview(picker)
    
    }
    
    func handleDatePicker(sender:UIDatePicker){
        self.setDateVariables(selectedDateAndTime: sender.date)
        dateLabel.text = displayDate
        timeTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        picker.removeFromSuperview()
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var tableViewHeader: UILabel!
    @IBOutlet weak var noTimesLabel: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDateVariables(selectedDateAndTime: Date())
        dateLabel.text = displayDate
        
        timeTableView.cellLayoutMarginsFollowReadableWidth = false
        
        timeTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableViewHeader.layer.backgroundColor = UIColor.lightGray.cgColor
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
