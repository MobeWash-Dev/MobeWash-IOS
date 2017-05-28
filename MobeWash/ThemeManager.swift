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
        
        //let proxyTextField = UITextField.appearance()
        //proxyTextField.backgroundColor = UIColor.clear
        //proxyTextField.textColor = MWColors.MWLightBlue
        //proxyTextField.font = MWStyles.bodyFont
        
        let proxyNavBar = CustomUINavBar.appearance()
        proxyNavBar.backgroundColor = MWColors.MWBlue
        //proxyNavBar.tintColor = MWColors.MWGray
        
        //let proxySearchBar = UISearchBar.appearance()
        //proxySearchBar.barTintColor = UIColor.white
        
        //let proxyLabel = UILabel.appearance()
        //proxyLabel.textColor = UIColor.black
        
//        let proxyButton = UIButton.appearance()
//        proxyButton.backgroundColor = MWColors.
//        proxyButton.setTitleColor(MWColors.MWLightBlue, for: .normal)
        
        let proxyCustomButton = CustomButton.appearance()
        //proxyCustomButton.backgroundColor = MWColors.MWDarkBlue
        proxyCustomButton.setTitleColor(MWColors.MWGreen, for: .normal)
        proxyCustomButton.backgroundColor = UIColor.clear
        //proxyCustomButton.layer.borderWidth = 3.0
        //proxyCustomButton.layer.borderColor = UIColor.red.cgColor
        //proxyCustomButton.setTitleColor(MWColors.MWLightBlue, for: .normal)
        
        //Swith Example
        //let proxySwitch = UISwitch.appearance()
        //proxySwitch.onTintColor = MWColors.MWPurple
    }
}
