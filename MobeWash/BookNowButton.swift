//
//  GreenButton.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/2/17.
//
//
import UIKit

class BookNowButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = MWColors.MWBlue.cgColor
        
    }
    
}
