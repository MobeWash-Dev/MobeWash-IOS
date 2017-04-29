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
    let availability = ["April": [28: [10, 11, 12], 29: [8, 14]]]
    
    var noneAvailable = false
    var selectedMonth = String()
    var selectedDate = Int()
    var displayDate = String()
    var selectedTime = String()

    @IBAction func selectDate(_ sender: UIButton) {
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
        print(selectedTime)
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
            noTimesLabel.isHidden = true
            timeTableView.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
