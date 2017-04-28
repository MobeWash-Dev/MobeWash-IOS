//
//  Ready2BookViewController.swift
//  MobeWash
//
//  Created by Shuangli Zhou on 4/27/17.
//
//

import UIKit

class Ready2BookViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var companyTable: UITableView!
    @IBOutlet weak var companyInput: UISearchBar!
    
     // Leon - dummy data for tableview
    var companies = ["Google", "Amazon", "UCSD", "United", "Apple", "Watermelon", "Leon's Awesome Company", "Alphabat", "Tesla"]
    var filtered = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Leon - set up new delegation method
        companyInput.delegate = self
        companyTable.delegate = self
        companyTable.dataSource = self
        filterData(withText: "")
        companyInput.showsCancelButton = true
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterData(withText: String) {
        
        // Leon - manually filter data
        if(filtered == []){
            filtered = self.companies
        }else{
            filtered = []
            for company in companies {
                if company.lowercased().hasPrefix(withText.lowercased()){
                    filtered.append(company)
                }
            }

        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Done editing")
        filterData(withText: companyInput.text!)
        self.companyTable.reloadData()
        companyInput.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        companyInput.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Changed")
        filterData(withText: searchText)
        self.companyTable.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count is " + String(self.filtered.count) )
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Leon - dequeue and set text
        let companycell = tableView.dequeueReusableCell( withIdentifier:"companyCell") as? CompanyCell!
        print("Name is " + filtered[indexPath.row])
        companycell?.nameText.text = filtered[indexPath.row]
        return companycell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
}
