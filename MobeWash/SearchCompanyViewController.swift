//
//  SearchCompanyViewController.swift
//  MobeWash
//
//  Created by Chad Lohrli on 6/10/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SearchCompanyViewController: UIViewController {
    
    //bookingData will be passed throughout view controllers during booking process
    var bookingData = Booking(calendarType: 1144452, appointmentTypeID: "", dateTime: "", firstName: "", lastName: "", email: "", phone: "", fields: [])
    
    var companyNames:[String] = []
    var companyIds:[Int] = []
    var companySelected:String = ""

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



    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        
        
    }
    
    
    
    
    

}
    




