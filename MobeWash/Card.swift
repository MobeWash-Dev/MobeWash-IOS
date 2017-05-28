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
    private var number: String
    private var last4: String
    private var expMonth, expYear: UInt
    private var typeImage: UIImage?
    private var color: UIColor?

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
