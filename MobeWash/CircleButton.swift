//
//  GreenButton.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/2/17.
//
//
import UIKit

class GreenButton: UIButton {
    
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
    }

}
