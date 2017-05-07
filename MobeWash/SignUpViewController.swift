//
//  SignUpViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 4/19/17.
//
//

import UIKit
import Alamofire
import SwiftHash

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userButtonOutlet: UIButton!
    @IBOutlet weak var washerButtonOutlet: UIButton!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var makeOfCar: UITextField!
    @IBOutlet weak var modelOfCar: UITextField!
    @IBAction func userButton(_ sender: UIButton) {
        userButtonOutlet.backgroundColor = UIColor.lightGray
        washerButtonOutlet.backgroundColor = UIColor.white
        makeOfCar.isHidden = false
        modelOfCar.isHidden = false
    }
    @IBAction func washerButton(_ sender: UIButton) {
        userButtonOutlet.backgroundColor = UIColor.white
        washerButtonOutlet.backgroundColor = UIColor.lightGray
        makeOfCar.isHidden = true
        modelOfCar.isHidden = true
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        
        //Testing Alamofire to create a user
        if (firstNameField.text?.characters.count != 0 &&
            passwordField.text?.characters.count != 0) {
         
            let name = firstNameField.text!
            let hashedPassword = MD5(passwordField.text!)
            
            let parameters: Parameters = [
                "name": name,
                "pass": hashedPassword]
            
            let userRequestURL = MWConfig.webApp + "/user"
            
            //Post request
            Alamofire.request(userRequestURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).response(completionHandler: { response in
                
                print("Request: \(response.request!)")
                print("Response: \(response.response!)")
                print("Error: \(response.error!)")
                
            })
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
