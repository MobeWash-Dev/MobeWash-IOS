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
        
        let proxySegmentedControl = UISegmentedControl.appearance()
        proxySegmentedControl.tintColor = MWColors.MWGreen
        
        let proxyTextField = UITextField.appearance()
        proxyTextField.backgroundColor = MWColors.MWLightGray
        
        let proxySwitch = UISwitch.appearance()
        proxySwitch.onTintColor = MWColors.MWPurple
    }
}
