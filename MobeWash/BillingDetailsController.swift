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

    var paymentTextField: STPPaymentCardTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paymentFrame = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 60)
        paymentTextField = STPPaymentCardTextField(frame: paymentFrame)
        paymentTextField.center = view.center
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        
        bookButton.isEnabled = false
        
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
        }
    }
    
}
