//
//  BookingAnimationView.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/27/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//
import UIKit

class BookingAnimationView: UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup () {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
    }
}
