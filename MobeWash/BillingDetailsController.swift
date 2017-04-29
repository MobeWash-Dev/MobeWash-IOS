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

    var addressLine: UITextField?
    var cityLine: UITextField?
    var postalLine: UITextField?
    var stateLine: UITextField?
    var countryLine: UITextField?
    
    //PKPayment variable(s)
    var paymentSucceeded: Bool = false
    
    //Data elements
    //var package = ...
    
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
        bookButtonApplePay?.isEnabled = Stripe.deviceSupportsApplePay()
        
    }
    
    func initViews() {

        let textFieldHeight: CGFloat = (self.view.frame.size.height / 13.0)
        
        //init buttons
        self.bookButton = BuyButton(enabled: true, theme: STPTheme.default())
        
        self.bookButtonApplePay = ApplePayBuyButton(enabled: true, theme: STPTheme.default())
        
        self.bookButton?.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
        
        self.bookButtonApplePay?.addTarget(self, action: #selector(bookButtonApplePayTapped), for: .touchUpInside)
        
        //init payment textField and Button Frames
        paymentTextField = STPPaymentCardTextField(frame: CGRect(x: 20, y: self.topView.frame.maxY + 35, width: self.view.frame.size.width - 40, height: textFieldHeight))
        
        paymentTextField.borderWidth = 0.25
        //init rest of textFields
        
        addressLine = UITextField(frame: CGRect(x: 20, y:self.paymentTextField.frame.maxY+5, width: self.view.frame.size.width - 40, height: textFieldHeight))
        addressLine?.borderStyle = UITextBorderStyle.roundedRect
        addressLine?.placeholder = "Billing Address"
        
        cityLine = UITextField(frame: CGRect(x: 20, y:self.addressLine!.frame.maxY+5, width: self.view.frame.size.width - 40, height: textFieldHeight))
        cityLine?.borderStyle = UITextBorderStyle.roundedRect
        cityLine?.placeholder = "City"
        
        stateLine = UITextField(frame: CGRect(x: 20, y:self.cityLine!.frame.maxY+5, width: (self.view.frame.size.width - 40)/2 - 5 , height: textFieldHeight))
        stateLine?.borderStyle = UITextBorderStyle.roundedRect
        stateLine?.placeholder = "State"
        
        postalLine = UITextField(frame: CGRect(x: stateLine!.frame.maxX + 5, y:self.cityLine!.frame.maxY+5, width: (self.view.frame.size.width - 40)/2 , height: textFieldHeight))
        postalLine?.borderStyle = UITextBorderStyle.roundedRect
        postalLine?.placeholder = "Postal Code"
        
        countryLine = UITextField(frame: CGRect(x: 20, y:self.postalLine!.frame.maxY+5, width: self.view.frame.size.width - 40, height: textFieldHeight))
        countryLine?.borderStyle = UITextBorderStyle.roundedRect
        countryLine?.placeholder = "Country"
        
        bookButton?.frame = CGRect(x: 20, y:self.countryLine!.frame.maxY+35, width: self.view.frame.size.width - 40, height: textFieldHeight)
        
        bookButtonApplePay?.frame = CGRect(x: 20, y:self.bookButton!.frame.maxY+5, width: self.view.frame.size.width - 40, height: textFieldHeight)
        
        
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
