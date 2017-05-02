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

class BillingDetailsViewController: UIViewController, STPPaymentCardTextFieldDelegate, PKPaymentAuthorizationViewControllerDelegate  {
    
    //UI elements
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var carImageView: UIImageView!

    @IBOutlet weak var paymentTextFieldPlaceholder: UIView!
    var paymentTextField: STPPaymentCardTextField!
    
    var bookButton: BuyButton?
    var bookButtonApplePay: ApplePayBuyButton?

    var addressLine: UITextField!
    var cityLine: UITextField?
    var postalLine: UITextField?
    var stateLine: UITextField?
    var countryLine: UITextField?
    
    //PKPayment variable(s)
    var paymentSucceeded: Bool = false
    
    //Data elements
    //var package = ...
    var billingData : NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViews()
        
        view.addSubview(paymentTextField)
        view.addSubview(addressLine!)
        view.addSubview(cityLine!)
        view.addSubview(stateLine!)
        view.addSubview(postalLine!)
        view.addSubview(countryLine!)
        view.addSubview(bookButton!)
        view.addSubview(bookButtonApplePay!)
        
        paymentTextField.delegate = self
        bookButton?.isEnabled = false
        bookButtonApplePay?.isEnabled = false
       // bookButtonApplePay?.isEnabled = Stripe.deviceSupportsApplePay()
        
        
        
        
    }
    
    func initViews() {

        //textfield frame layout constants
        let textFieldHeight = self.view.frame.size.height / 13.0
        let textFieldWidth = self.view.frame.size.width - 40
        
        //init textFields and Buttons
        self.bookButton = BuyButton(enabled: true, theme: STPTheme.default())
        self.bookButtonApplePay = ApplePayBuyButton(enabled: true, theme: STPTheme.default())
        
        //add targets
        self.bookButton?.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
        self.bookButtonApplePay?.addTarget(self, action: #selector(bookButtonApplePayTapped), for: .touchUpInside)
        
        //init payment textField and Button Frames
        
        let paymentTextFieldFrame = CGRect(x: 20, y: self.topView.frame.maxY + 35, width: textFieldWidth, height: textFieldHeight)
        
        let addressLineFrame = CGRect(x: 20, y:paymentTextFieldFrame.maxY+5, width: textFieldWidth, height: textFieldHeight)
        
        let cityLineFrame = CGRect(x: 20, y:addressLineFrame.maxY+5, width: self.view.frame.size.width - 40, height: textFieldHeight)
        
        let stateLineFrame = CGRect(x: 20, y:cityLineFrame.maxY+5, width: textFieldWidth/2 - 5 , height: textFieldHeight)
        
        let postalLineFrame = CGRect(x: stateLineFrame.maxX + 5, y:cityLineFrame.maxY+5, width: textFieldWidth/2 , height: textFieldHeight)
        
        let countryLineFrame = CGRect(x: 20, y:postalLineFrame.maxY+5, width: textFieldWidth, height: textFieldHeight)
        
        let bookButtonFrame = CGRect(x: 20, y:countryLineFrame.maxY+35, width: textFieldWidth, height: textFieldHeight)
        
        let bookButtonApplePayFrame = CGRect(x: 20, y:bookButtonFrame.maxY+5, width: textFieldWidth, height: textFieldHeight)
        

        //set textField and button frames
    
        paymentTextField = STPPaymentCardTextField(frame: paymentTextFieldFrame)
        paymentTextField.borderWidth = 0.25
        
        addressLine = UITextField(frame: addressLineFrame, borderStyle: .roundedRect, placeholder: "Billing Address")
        
        cityLine = UITextField(frame: cityLineFrame, borderStyle: .roundedRect, placeholder: "City")
    
        stateLine = UITextField(frame: stateLineFrame, borderStyle: .roundedRect, placeholder: "State")

        postalLine = UITextField(frame: postalLineFrame, borderStyle: .roundedRect, placeholder: "Postal Code")
        
        countryLine = UITextField(frame: countryLineFrame, borderStyle: .roundedRect, placeholder: "Country")
        
        bookButton?.frame = bookButtonFrame
    
        bookButtonApplePay?.frame = bookButtonApplePayFrame
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Layout topView
        topView.layer.masksToBounds = true
        topView.layer.borderWidth = 0.5
        topView.layer.borderColor = UIColor.lightGray.cgColor
        topView.layer.cornerRadius = 10
    }
    
    func bookButtonTapped() {
        
        //check if all billing data fields are set 
        for view: UIView in view.subviews {
            if (view is UITextField) {
                let textField: UITextField? = (view as? UITextField)
                if textField?.text?.characters.count == 0 {
                    print("Fill out all billing details")
                    return
                }
            }
        }
        
        //package billing data
        billingData = NSMutableDictionary()
        billingData?.setValue(addressLine!.text, forKey: "address")
        billingData?.setValue(cityLine!.text, forKey: "city")
        billingData?.setValue(stateLine!.text, forKey: "state")
        billingData?.setValue(postalLine!.text, forKey: "zip")
        billingData?.setValue(countryLine!.text, forKey: "country")
        
        
        let card = paymentTextField.cardParams
        STPAPIClient.shared().createToken(withCard: card) { (token, error) in
            if let error = error {
                print(error)
                
            }else if token != nil {
                self.chargeCard(token!, completion: { (error) in
                    if error != nil {
                        print("Error charging card")
                    } else {
                        print("Success")
                        //segue to booked! page
                    }
                })
            }
        }
        
    }
    
    func bookButtonApplePayTapped(){
        
        //get these variables from package object intialzed from delegation method
        let package = "Mobe"
        let amount = "24.00"
        
        let paymentRequest: PKPaymentRequest? = Stripe.paymentRequest(withMerchantIdentifier: "com.merchant.mobewash")
        
        paymentRequest?.paymentSummaryItems = [
            PKPaymentSummaryItem(label: package, amount: NSDecimalNumber(string:amount))
        ]
        
        if let paymentRequest = paymentRequest, Stripe.canSubmitPaymentRequest(paymentRequest) {
            let paymentAuthorizationVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            paymentAuthorizationVC.delegate = self as UIViewController as? PKPaymentAuthorizationViewControllerDelegate
            self.present(paymentAuthorizationVC, animated: true, completion: nil)
        } else {
            print("Error with Apple Pay")
        }
        
        
        
    }
    
    func chargeCard(_ token: STPToken, completion: (_ error: Error?) -> Void) {
        
        
        //let params = ["stripeToken": token, "amount": 24]
        
        //TODO: Send data to API
        
        //if successful ...
        completion(nil)
    
        
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        
        if textField.valid{
            bookButton?.isEnabled = true
        }else{
            bookButton?.isEnabled = false
        }
    }
    
    
    // MARK: PKPaymentAuthorizationViewControllerDelegate
  
    
    

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        STPAPIClient.shared().createToken(with: payment) { (token, error) in
            
            self.chargeCard(token!, completion: { (error) in
                if error != nil{
                    completion(.failure)
                    print("Error charging card")
                } else {
                    self.paymentSucceeded = true
                    completion(.success)
                    
                }
            })
        }
        
    }
    
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        self.dismiss(animated: true, completion: {
            if (self.paymentSucceeded) {
                print("Success")
                //segue to booked! page
            }
        })
    }
    
}
