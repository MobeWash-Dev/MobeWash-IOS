//
//  BillingDetailsWithCardViewController.swift
//  MobeWash
//
//  Created by Chad Lohrli on 5/27/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation
import UIKit
import Stripe

class BillingDetailsWithCardViewController: UIViewController {
    

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var licensePlate: UILabel!
    
    @IBOutlet weak var cardFrame: UIView!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardExpiration: UILabel!
    @IBOutlet weak var cardTypeImage: UIImageView!
    @IBOutlet weak var cardBackground: UIImageView!
    
    @IBOutlet weak var payLabel: UILabel!
    
    @IBOutlet weak var addNewCardButton: UIButton!
    @IBOutlet weak var payWithCardButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    
    var saveCardButton: BuyButton?
    
    var paymentTextField: STPPaymentCardTextField!
    var cardArray:[Card] = []
    var currentCard:Card?
    var hasCard:Bool = false
    var hiddenCardElements:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in didload \(cardNumber.frame)")
        
        initViews()
        
        hiddenCardElements = [cardNumber,cardExpiration,cardTypeImage,payLabel]
        
        //Dummy Data
        let card1 = Card(number: "••••••••••••4242", last4: "4242", expMonth: 09, expYear: 20, typeImage: UIImage(named:"stp_card_visa.png"), color: UIColor.blue)
        
        let card2 = Card(number: "••••••••••••5555", last4: "5555", expMonth: 08, expYear: 19, typeImage: UIImage(named:"stp_card_amex.png"), color: UIColor.green)
        
        cardArray = [card1,card2]
        currentCard = cardArray[0]
        updateCard(card: currentCard!)
        
        
        //check if user has any cards
        if (!cardArray.isEmpty){
            hasCard = true
        }else{
            showAddCard()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("in appear \(cardNumber.frame)")
        
        //Programatic UI that references storyboard frames must be initialized
        //here to ensure all frames are definite
        
        //init addCard UI
        paymentTextField = STPPaymentCardTextField(frame: cardNumber.frame)
        cardFrame.addSubview(paymentTextField)
        paymentTextField.isHidden = true
        
        //set up delegation
        paymentTextField.delegate = self
        
        saveCardButton = BuyButton(enabled: true, theme: .default())
        let saveCardFrame = CGRect(x: cardExpiration.frame.minX, y: cardExpiration.frame.minY, width: cardExpiration.frame.width + 20, height: cardExpiration.frame.height + 5)
        saveCardButton?.frame = saveCardFrame
        saveCardButton?.setTitle("add", for: .normal)
        cardFrame.addSubview(saveCardButton!)
        saveCardButton?.isEnabled = false
        saveCardButton?.isHidden = true
        
        //add button targets
        self.saveCardButton!.addTarget(self, action: #selector(saveCardButtonTapped), for: .touchUpInside)
        
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

    func initViews(){
        
        //Will reduce reptition once stylesheet is fully updated
        
        firstName.textColor = MWColors.MWBlue
        lastName.textColor = MWColors.MWBlue
        make.textColor = MWColors.MWBlue
        color.textColor = MWColors.MWBlue
        licensePlate.textColor = MWColors.MWBlue
    
        cardFrame.layer.masksToBounds = true
        cardFrame.layer.borderWidth = 0.5
        cardFrame.layer.borderColor = MWColors.MWBlue.cgColor
        cardFrame.layer.cornerRadius = 10
        cardBackground.image = UIImage(named: "world.png")
        

        payWithCardButton.layer.masksToBounds = true
        payWithCardButton.layer.borderWidth = 2
        payWithCardButton.layer.borderColor = MWColors.MWBlue.cgColor
        payWithCardButton.layer.cornerRadius = 10
        payWithCardButton.backgroundColor = MWColors.MWBlue
        
        applePayButton.layer.masksToBounds = true
        applePayButton.layer.borderWidth = 2
        applePayButton.layer.borderColor = UIColor.black.cgColor
        applePayButton.layer.cornerRadius = 10
        applePayButton.backgroundColor = UIColor.black
        

        //remove these lines, they just demonstrate the constraints are off
        cardNumber.layer.borderWidth = 2
        cardNumber.layer.borderColor = UIColor.black.cgColor
        cardExpiration.layer.borderWidth = 2
        cardExpiration.layer.borderColor = UIColor.black.cgColor
    
    }
    
    // MARK : IBACTIONS
    @IBAction func changeCardRight(_ sender: Any) {

        currentCard = cardArray[1]
        updateCard(card: currentCard!)
        
    }

    @IBAction func changeCardLeft(_ sender: Any) {
        
        currentCard = cardArray[0]
        updateCard(card: currentCard!)
    }
    
    
    func updateCard(card:Card){
        
        cardNumber.text = card.number
        cardExpiration.text = "\(card.expMonth)/\(card.expYear)"
        cardTypeImage.image = card.typeImage!
        

    }
    @IBAction func addCard(_ sender: Any) {
        showAddCard()
    }
    
    
    // MARK : Add Card Functionality Methods
    func showAddCard(){
        
        if(addNewCardButton.titleLabel!.text! == "Cancel"){
            for item in hiddenCardElements{
                (item as? UIView)?.isHidden = false
            }
            paymentTextField.isHidden = true
            saveCardButton?.isHidden = true
        
            addNewCardButton.setTitle("add a new card", for: .normal)
            addNewCardButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            return
        }
  
        //hide original data
        for item in hiddenCardElements{
            (item as? UIView)?.isHidden = true
        }
        
        addNewCardButton.setTitle("Cancel", for: .normal)
        addNewCardButton.setTitleColor(UIColor.red, for: .normal)
        
        //show paymentField & button
        paymentTextField.isHidden = false
        saveCardButton?.isHidden = false
        
    }
    
    func saveCardButtonTapped (){
        
        //TODO : add card functionality includes saving card in to stripe via API calls
        
        //assume successful for demo
        showAddCard()
        MWAlerts.alertMessage(message: "Successfully Saved Card!", sender: self)
        
        
    }
    
}

// MARK : Stripe Delegate Methods

extension BillingDetailsWithCardViewController: STPPaymentCardTextFieldDelegate{
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        
        if textField.valid{
            saveCardButton!.isEnabled = true
        }else{
            saveCardButton!.isEnabled = false
        }
        
        
    }
}




