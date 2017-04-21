//
//  ViewController.swift
//  MobeWash
//
//  Created by Sean Ippolito on 4/16/17.
//
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        print("Successful Login")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

