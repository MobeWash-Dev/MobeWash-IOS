//
//  UserDetails.swift
//  MobeWash
//
//  Created by Chad Lohrli on 5/28/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UITextFieldDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var textFields = [UITextField]()
        textFields = [firstName, lastName, phoneNumber, emailField, makeAndModel,
                      colorField, licenseField, extraInfo]
        
        for item in textFields{
            item.borderStyle = .roundedRect
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

