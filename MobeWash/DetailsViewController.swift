//
//  DetailsViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 4/26/17.
//
//

import UIKit

class DetailsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var makeAndModel: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var licenseField: UITextField!
    @IBOutlet weak var extraInfo: UITextField!
    @IBAction func nextButton(_ sender: UIButton) {
    }
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var textFields = [UITextField]()
        textFields = [firstName, lastName, phoneNumber, emailField, makeAndModel,
                        colorField, licenseField, extraInfo]
        
        for item in textFields{
            item.borderStyle = .roundedRect
        }
        
        nextButtonOutlet.backgroundColor = UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1)
        nextButtonOutlet.setTitleColor(UIColor.white, for: [])

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
