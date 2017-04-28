//
//  Ready2BookViewController.swift
//  MobeWash
//
//  Created by Shuangli Zhou on 4/27/17.
//
//

import UIKit

class Ready2BookViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var companyInput: UITextField!
    @IBOutlet weak var companyTable: UITableView!
    
     // Leon - dummy data for tableview
    var companies = ["Google", "Amazon", "UCSD", "United", "Apple", "Watermelon", "Leon's Awesome Company"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Leon - set up new delegation method
        companyInput.delegate = self
        companyTable.delegate = self
        companyTable.dataSource = self
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("edited")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count is " + String(self.companies.count) )
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue and set text
        let companycell = tableView.dequeueReusableCell( withIdentifier:"companyCell") as? CompanyCell!
        print("Name is " + companies[indexPath.row])
        companycell?.nameText.text = companies[indexPath.row]
        return companycell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
}
