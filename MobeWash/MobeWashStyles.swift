//
//  MobeWashStyles.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/1/17.
//
//

import UIKit

class MWColors {
    static let MWGreen = UIColor(red: 141 / 255 , green: 198 / 255 , blue: 63 / 255 , alpha: 1.0 )
    static let MWGray = UIColor(red: 84 / 255 , green: 88 / 255 , blue: 90 / 255 , alpha: 1.0 )
    static let MWOrange = UIColor(red: 246 / 255 , green: 190 / 255 , blue: 0 / 255 , alpha: 1.0 )
    static let MWBlue = UIColor(red: 0 / 255 , green: 114 / 255 , blue: 206 / 255 , alpha: 1.0 )
    static let MWPurple = UIColor(red: 131 / 255 , green: 49 / 255 , blue: 119 / 255 , alpha: 1.0 )
    static let MWLightGray = UIColor(red: 217 / 255 , green: 217 / 255 , blue: 214 / 255 , alpha: 1.0 )
}

class MWStyles {
    static let bodyFont = UIFont(name: "ArialMT" , size: 14.0 )
    static let titleFont = UIFont(name: "Avenir-Light" , size: 32.0 )
    static let normalButtonFont = UIFont(name: "ArialMT" , size: 14.0 )
    static let importantButtonFont = UIFont(name: "Arial-BoldMT" , size: 14.0 )
    
    static let normalButtonBackgroundColor = MWColors.MWLightGray
    static let importantButtonBackgroundColor = MWColors.MWOrange
    static let buttonTextColor = MWColors.MWGray
}
