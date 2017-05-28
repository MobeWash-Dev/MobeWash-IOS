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
    
    @IBOutlet weak var addNewCardButton: UIButton!
    @IBOutlet weak var payWithCardButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    
    var cardArray:[Card] = []
    var currentCard:Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    
        let card1 = Card(number: "••••••••••••4242", last4: "4242", expMonth: 09, expYear: 20, typeImage: UIImage(named:"stp_card_visa.png"), color: UIColor.blue)
        
        let card2 = Card(number: "••••••••••••5555", last4: "5555", expMonth: 08, expYear: 19, typeImage: UIImage(named:"stp_card_amex.png"), color: UIColor.green)
        
        cardArray = [card1,card2]
        currentCard = cardArray[0]
        updateCard(card: currentCard!)

        
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

    
    }
    
    // MARK -- IBACTIONS
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
    
}
