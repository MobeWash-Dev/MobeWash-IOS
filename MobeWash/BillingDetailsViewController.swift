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

class BillingDetailsViewController: UIViewController, STPPaymentContextDelegate {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var paymentTextFieldPlaceholderView: UIView!
    
    var paymentTextField: STPPaymentCardTextField!
    var bookBuyButton: BuyButton?
    var bookApplyPayBuyButton: ApplePayBuyButton?
    var addressTextField: UITextField?
    var cityTextField: UITextField?
    var postalTextField: UITextField?
    var stateTextField: UITextField?
    var countryTextField: UITextField?
    
    var paymentSucceeded: Bool = false
    var billingDataMutableDictionary : NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initViews()
        
        view.addSubview(paymentTextField)
        view.addSubview(addressTextField!)
        view.addSubview(cityTextField!)
        view.addSubview(stateTextField!)
        view.addSubview(postalTextField!)
        view.addSubview(countryTextField!)
        view.addSubview(bookBuyButton!)
        view.addSubview(bookApplyPayBuyButton!)
        
        paymentTextField.delegate = self
        bookBuyButton?.isEnabled = false
        bookApplyPayBuyButton?.isEnabled = false
       // bookApplyPayBuyButton?.isEnabled = Stripe.deviceSupportsApplePay()
        
        
        
    }
    
    func initViews() {

        //textfield frame layout constants
        let textFieldHeight = self.view.frame.size.height / 13.0
        let textFieldWidth = self.view.frame.size.width - 40
        
        //init textFields and Buttons
        self.bookBuyButton = BuyButton(enabled: true, theme: STPTheme.default())
        self.bookApplyPayBuyButton = ApplePayBuyButton(enabled: true, theme: STPTheme.default())
        
        //add targets
        self.bookBuyButton?.addTarget(self, action: #selector(bookBuyButtonTapped), for: .touchUpInside)
        self.bookApplyPayBuyButton?.addTarget(self, action: #selector(bookApplePayBuyButtonTapped), for: .touchUpInside)
        
        //init payment textField and Button Frames
        
        let paymentTextFieldFrame = CGRect(x: 20, y: self.topView.frame.maxY + 35, width: textFieldWidth, height: textFieldHeight)
        
        let addressTextFieldFrame = CGRect(x: 20, y:paymentTextFieldFrame.maxY+5, width: textFieldWidth, height: textFieldHeight)
        
        let cityTextFieldFrame = CGRect(x: 20, y:addressTextFieldFrame.maxY+5, width: self.view.frame.size.width - 40, height: textFieldHeight)
        
        let stateTextFieldFrame = CGRect(x: 20, y:cityTextFieldFrame.maxY+5, width: textFieldWidth/2 - 5 , height: textFieldHeight)
        
        let postalTextFieldFrame = CGRect(x: stateTextFieldFrame.maxX + 5, y:cityTextFieldFrame.maxY+5, width: textFieldWidth/2 , height: textFieldHeight)
        
        let countryTextFieldFrame = CGRect(x: 20, y:postalTextFieldFrame.maxY+5, width: textFieldWidth, height: textFieldHeight)
        
        let bookBuyButtonFrame = CGRect(x: 20, y:countryTextFieldFrame.maxY+35, width: textFieldWidth, height: textFieldHeight)
        
        let bookApplyPayBuyButtonFrame = CGRect(x: 20, y:bookBuyButtonFrame.maxY+5, width: textFieldWidth, height: textFieldHeight)
        

        //set textField and button frames
    
        paymentTextField = STPPaymentCardTextField(frame: paymentTextFieldFrame)
        paymentTextField.borderWidth = 0.25
        
        addressTextField = UITextField(frame: addressTextFieldFrame, borderStyle: .roundedRect, placeholder: "Billing Address")
        
        cityTextField = UITextField(frame: cityTextFieldFrame, borderStyle: .roundedRect, placeholder: "City")
    
        stateTextField = UITextField(frame: stateTextFieldFrame, borderStyle: .roundedRect, placeholder: "State")

        postalTextField = UITextField(frame: postalTextFieldFrame, borderStyle: .roundedRect, placeholder: "Postal Code")
        
        countryTextField = UITextField(frame: countryTextFieldFrame, borderStyle: .roundedRect, placeholder: "Country")
        
        bookBuyButton?.frame = bookBuyButtonFrame
    
        bookApplyPayBuyButton?.frame = bookApplyPayBuyButtonFrame
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topView.layer.masksToBounds = true
        topView.layer.borderWidth = 0.5
        topView.layer.borderColor = UIColor.lightGray.cgColor
        topView.layer.cornerRadius = 10
    }
    
    // MARK -- STPPaymentContextDelegate
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {

    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didCreatePaymentResult paymentResult: STPPaymentResult,
                        completion: @escaping STPErrorBlock) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFinishWith status: STPPaymentStatus,
                        error: Error?) {
        
      
    }
    

    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFailToLoadWithError error: Error) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension BillingDetailsViewController: PKPaymentAuthorizationViewControllerDelegate  {
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

extension BillingDetailsViewController: STPPaymentCardTextFieldDelegate {
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        if textField.valid{
            bookBuyButton?.isEnabled = true
        }else{
            bookBuyButton?.isEnabled = false
        }
    }
}

extension BillingDetailsViewController {
    func bookBuyButtonTapped() {
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
        self.billingDataMutableDictionary?.setValue(addressTextField!.text, forKey: "address")
        self.billingDataMutableDictionary?.setValue(cityTextField!.text, forKey: "city")
        self.billingDataMutableDictionary?.setValue(stateTextField!.text, forKey: "state")
        self.billingDataMutableDictionary?.setValue(postalTextField!.text, forKey: "zip")
        self.billingDataMutableDictionary?.setValue(countryTextField!.text, forKey: "country")
        
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
    
    func bookApplePayBuyButtonTapped(){
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
}
