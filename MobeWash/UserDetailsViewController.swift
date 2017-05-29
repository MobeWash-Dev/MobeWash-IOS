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
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var makeField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var licenseField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var infoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var textFields = [UITextField]()
        textFields = [firstNameField, lastNameField, phoneField, emailField, makeField,
                      colorField, licenseField, infoField]
        
        for item in textFields{
            item.borderStyle = .roundedRect
        }
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
