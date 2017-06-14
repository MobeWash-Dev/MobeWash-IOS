//
//  SearchCompanyViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 6/13/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import Alamofire

class SearchCompanyViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    //bookingData will be passed throughout view controllers during booking process
    var bookingData = Booking(calendarType: 1144452, appointmentTypeID: 0, dateTime: "", firstName: "", lastName: "", email: "", phone: "", fields: [])

    var companyNames:[String] = []
    var companyIds:[Int] = []
    var companySelected:String = ""

    @IBOutlet weak var firstSuggestedCompanyButtonOutlet: UIButton!
    @IBOutlet weak var secondSuggestedCompanyButtonOutlet: UIButton!
    @IBOutlet weak var suggestCompanyLabel: UILabel!
    @IBOutlet weak var pickCompanyLabel: UILabel!
    
    @IBOutlet weak var companiesTableView: UITableView!
    @IBOutlet weak var blueSearchBarStyle: UIView!
    @IBOutlet weak var companySearchBar: UISearchBar!
    
    var companies = ["Google", "Amazon", "UCSD", "United", "Apple", "Watermelon", "Leon's Awesome Company", "Alphabat", "Tesla"]
    var filtered = [String]()
    
    var originalSearchBarY = CGFloat()
    var originalTableViewY = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //GET company names
        Alamofire.request("https://mobe-server.herokuapp.com/api/company").responseJSON { response in

            if let JSON = response.result.value as? [[String:Any]] {
                for outer in JSON{
                    for (key,value) in outer{
                        if (key == "name"){
                            print(value)
                            self.companyNames.append(value as! String)
                        }else if(key == "id"){
                            self.companyIds.append(value as! Int)
                            print(value)
                        }
                    }
                }
            }

            //contains id(key) company name(value)
            //company id is needed to api call later down the line when we collect slot size etc.
            var companyData:[Int:String] = [:]

            for item in self.companyIds{
                companyData[item] = self.companyNames[item-1]
            }

        }

        // TODO -- populate table view with companyNames array data

        companiesTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        companiesTableView.layoutMargins = .zero

        companySearchBar.delegate = self
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        companiesTableView.isHidden = true

        originalSearchBarY = companySearchBar.frame.origin.y + companySearchBar.frame.height
        originalTableViewY = companiesTableView.frame.origin.y + companiesTableView.frame.height
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        companySearchBar.showsCancelButton = false
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                // 30 is where animation starts
                companySearchBar.frame.origin.y = 30 + companySearchBar.frame.height
                blueSearchBarStyle.frame.origin.y = companySearchBar.frame.origin.y
                companiesTableView.frame.origin.y = 30 + (companySearchBar.frame.height*2)
                companiesTableView.frame.size.height = UIScreen.main.bounds.height - companySearchBar.frame.maxY - keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        companySearchBar.frame.origin.y = originalSearchBarY
        blueSearchBarStyle.frame.origin.y = companySearchBar.frame.origin.y
        companiesTableView.frame.origin.y = originalTableViewY
    }
    
    func filterData(withText: String) {
        if(withText == ""){
            filtered = self.companies
            companiesTableView.isHidden = false
        } else {
            filtered = []
            for company in companies {
                if company.lowercased().hasPrefix(withText.lowercased()){
                    filtered.append(company)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterData(withText: companySearchBar.text!)
        self.companiesTableView.reloadData()
        companySearchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        companySearchBar.showsCancelButton = false
        companySearchBar.text = ""
        companiesTableView.isHidden = true
        companySearchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if(searchBar.text == ""){
            filterData(withText: "")
            self.companiesTableView.reloadData()
        }
        companySearchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        companySearchBar.showsCancelButton = true
        companiesTableView.isHidden = false
        filterData(withText: searchText)
        self.companiesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Count is " + String(self.filtered.count) )
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let companyCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"companyCell")
        companyCell.textLabel?.text = filtered[indexPath.row]
        return companyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let companySelected = filtered[indexPath.row]
        self.performSegue(withIdentifier: "segueToPickAService", sender: self);
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

    // MARK -- Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let companyField = Field(name: "company", value: companySelected)
        bookingData.addField(field: companyField)

        if let destinationViewController = segue.destination as? PickAServiceViewController{
            destinationViewController.bookingData = self.bookingData
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
