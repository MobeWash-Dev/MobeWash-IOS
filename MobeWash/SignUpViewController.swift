//
//  SignUpViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 4/19/17.
//
//

import UIKit

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
    
    @IBOutlet weak var signupButton: UIButton!
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
        if let firstName = firstNameField.text,
            let lastName = lastNameField.text,
            let number = numberField.text,
            let email = emailField.text,
            let password = passwordField.text{
            if firstName.isEmpty || lastName.isEmpty ||
                number.isEmpty || email.isEmpty || password.isEmpty {
                showAlert(title: "Error:", message: "One of the fields is empty!", actionTitle: "OK")
            }
            else {
                if !phoneValidation(number: number) {
                    showAlert(title: "Error:", message: "Phone Number is not valid.", actionTitle: "OK")

                }
                else if !emailValidation(email: email) {
                    showAlert(title: "Error:", message: "Email is not valid.", actionTitle: "OK")
                }
                else if !pwValidation(password: password) {
                    showAlert(title: "Error:", message: "Password Must be 8 digits which contains at least one special character: !@#$&*, Please try again!", actionTitle: "OK")
                }
            }
        }
        print(firstNameField.text!)
    }
    func emailValidation(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result =  emailTest.evaluate(with: email)
        return result
    }
    func phoneValidation(number: String) -> Bool {
        let phoneRegEx = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let result =  phoneTest.evaluate(with: number)
        return result
    }
    func pwValidation(password: String) -> Bool {
        let pwRegEx = "^(?=.*[A-Z0-9a-z])(?=.*[!@#$&*]).{8}$"
        let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        let result =  pwTest.evaluate(with: password)
        return result
    }
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
