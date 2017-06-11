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
    
    var bookingData:Booking?
    
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
    
    //Error checking
    func checkTextFields (){
        
        for view: UIView in view.subviews{
            if (view is UITextField){
                let textField:UITextField? = (view as? UITextField)
                if textField?.text?.characters.count == 0 {
                    MWAlerts.alertMessage(message: "Please fill out all details",sender: self)
                    return
                }
            }
        }
        
        updateBookingObject()
        
    }
    
    private func updateBookingObject () {
        
        bookingData?.firstName = firstNameField.text!
        bookingData?.lastName = lastNameField.text!
        bookingData?.phone = phoneField.text!
        bookingData?.email = emailField.text!
        
        bookingData?.addField(field: Field(name: "Location Details", value: infoField.text!))
        
        //get last 4 digits of license plate
        let ln = licenseField.text!
        let index = ln.index(ln.startIndex, offsetBy: 4)
        
        bookingData?.addField(field: Field(name: "Last 4 of License Plate", value: ln.substring(to: index)))
        bookingData?.addField(field: Field(name: "Car Color", value: colorField.text!))
        bookingData?.addField(field: Field(name: "Car Make and Model", value: makeField.text!))
        
    }

    // MARK -- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let destinationViewController = segue.destination as? BillingDetailsWithCardViewController{
            destinationViewController.bookingData = self.bookingData
        }
        
    }
    
}
