//
//  BillingTextField.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/10/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import UIKit

class BillingTextField: UITextField, UITextFieldDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        createBorder()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        createBorder()
    }
    func createBorder(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 55/255, green: 78/255, blue: 95/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        //print("border created")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("focused")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("lost focus")
    }
}


