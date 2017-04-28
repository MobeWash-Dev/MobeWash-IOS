//
//  BillingDetailsController.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/27/17.
//
//

import Foundation
import UIKit
import Stripe

class BillingDetailsViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var bookButton: UIButton!

    @IBOutlet weak var paymentTextFieldPlaceholder: UIView!
    var paymentTextField: STPPaymentCardTextField!
    
    var addressLine: UITextField?
    var cityLine: UITextField?
    var postalLine: UITextField?
    var stateLine: UITextField?
    var countryLine: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.layer.masksToBounds = true
        topView.layer.borderWidth = 0.5
        topView.layer.borderColor = UIColor.lightGray.cgColor
        topView.layer.cornerRadius = 10
        
        
        
        
        let paymentFrame = CGRect(x: 20, y: self.topView.frame.maxY + 35, width: self.view.frame.size.width - 40, height: 60)
        
        //let paymentFrame = paymentTextFieldPlaceholder.frame
        paymentTextField = STPPaymentCardTextField(frame: paymentFrame)

        paymentTextFieldPlaceholder.addSubview(paymentTextField)
        //paymentTextField.center = view.center
        paymentTextField.borderWidth = 0.25
        
        addressLine = UITextField(frame: CGRect(x: 20, y:self.paymentTextField.frame.maxY+5, width: self.view.frame.size.width - 40, height: 60))
         addressLine?.borderStyle = UITextBorderStyle.roundedRect
        addressLine?.placeholder = "Billing Address"
        
        cityLine = UITextField(frame: CGRect(x: 20, y:self.addressLine!.frame.maxY+5, width: self.view.frame.size.width - 40, height: 60))
        cityLine?.borderStyle = UITextBorderStyle.roundedRect
        cityLine?.placeholder = "City"
        
        stateLine = UITextField(frame: CGRect(x: 20, y:self.cityLine!.frame.maxY+5, width: (self.view.frame.size.width - 40)/2 - 5 , height: 60))
        stateLine?.borderStyle = UITextBorderStyle.roundedRect
        stateLine?.placeholder = "State"
        
        postalLine = UITextField(frame: CGRect(x: stateLine!.frame.maxX + 5, y:self.cityLine!.frame.maxY+5, width: (self.view.frame.size.width - 40)/2 , height: 60))
        postalLine?.borderStyle = UITextBorderStyle.roundedRect
        postalLine?.placeholder = "Postal Code"

        countryLine = UITextField(frame: CGRect(x: 20, y:self.postalLine!.frame.maxY+5, width: self.view.frame.size.width - 40, height: 60))
        countryLine?.borderStyle = UITextBorderStyle.roundedRect
        countryLine?.placeholder = "Country"
        
        
        
        view.addSubview(paymentTextField)
        view.addSubview(addressLine!)
        view.addSubview(cityLine!)
        view.addSubview(stateLine!)
        view.addSubview(postalLine!)
        view.addSubview(countryLine!)
        
        
        paymentTextField.delegate = self
        bookButton.isEnabled = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    
    }
    
    @IBAction func bookButtonTapped(_ sender: Any) {
        
        let card = paymentTextField.cardParams
        STPAPIClient.shared().createToken(withCard: card) { (token, error) in
            if let error = error {
                print(error)
                
            }else if let token = token {
                self.chargeCard(token)
            }
        }
        
    }
    
    func chargeCard(_ token: STPToken) {
        
        //let params = ["stripeToken": token, "amount": 24]
        
        //TODO: Send data to API
        
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        
        if textField.valid{
            bookButton.isEnabled = true
        }else{
            bookButton.isEnabled = false
        }
    }
    
}
