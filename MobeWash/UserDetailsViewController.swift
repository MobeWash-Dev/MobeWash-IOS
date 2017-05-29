//
//  UserDetailsViewController.swift
//  MobeWash
//
//  Created by Chad Lohrli on 5/28/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    
}
