//
//  ThemeManager.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/1/17.
//
//

import UIKit

class ThemeManager {
    static func applyTheme() {
        
        //SegmentedControl Example
        //let proxySegmentedControl = UISegmentedControl.appearance()
        //proxySegmentedControl.tintColor = MWColors.MWGreen
        
        let proxyTextField = UITextField.appearance()
        proxyTextField.backgroundColor = MWColors.MWGreen
        //proxyTextField.textColor = MWStyles.buttonTextColor
        //proxyTextField.font = MWStyles.bodyFont
        
        
        let proxyLabel = UILabel.appearance()
        proxyLabel.textColor = MWColors.MWLightBlue
        
        let proxyButton = UIButton.appearance()
        proxyButton.backgroundColor = MWColors.MWOrange
        proxyButton.setTitleColor(MWColors.MWGray, for: .normal)
        
        let proxyGreenButton = GreenButton.appearance()
        proxyGreenButton.backgroundColor = MWColors.MWGreen
        proxyGreenButton.setTitleColor(MWColors.MWGray, for: .normal)
        
        //Swith Example
        //let proxySwitch = UISwitch.appearance()
        //proxySwitch.onTintColor = MWColors.MWPurple
    }
}
