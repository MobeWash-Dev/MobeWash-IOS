//
//  PickAServiceViewController.swift
//  MobeWash
//
//  Created by Chad Lohrli on 6/10/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PickAServiceViewController: UIViewController {

    var services:[Int:String] = [2925879:"Mobe",2944155:"MobePlus"]
    var serviceSelectedId:Int?
    var bookingData:Booking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GET Services available
        Alamofire.request("https://mobe-server.herokuapp.com/api/service").responseJSON { response in
            
            if let JSON = response.result.value as? [[String:Any]] {
                for outer in JSON{
                    for (key,value) in outer{
                        if (key == "serviceName"){
                            print(value)
                        }
                    }
                }
            }
            
        }
        
        // TODO -- populate service buttons 
        
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
        
        if let destinationViewController = segue.destination as? CalendarViewController{
            destinationViewController.bookingData = self.bookingData
        }
        
    }
    
        
    
        
}
