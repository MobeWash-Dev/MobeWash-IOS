//
//  Card.swift
//  MobeWash
//
//  Created by Chad Lohrli on 5/27/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation
import UIKit

public class Card {
    var number: String
    var last4: String
    var expMonth, expYear: UInt
    var typeImage: UIImage?
    var color: UIColor?

    init(number: String, last4: String, expMonth: UInt, expYear: UInt,
         typeImage: UIImage?, color: UIColor?) {
        
        self.number = number
        self.last4 = last4
        self.expYear = expYear
        self.expMonth = expMonth
        self.typeImage = typeImage
        self.color = color
        
    }
    
  
    
}
