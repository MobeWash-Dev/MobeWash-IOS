//
//  Company.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/26/17.
//
//

import Foundation

public class Company {
    
    private var uid: String
    private var name: String
    private var location: String
    private var setting: CompanySetting
    private var months: [String]
    
    init(name: String, location: String, setting: CompanySetting, months: [String]){
        self.uid = UUID().uuidString
        self.name = name
        self.location = location
        self.setting = setting
        self.months = months
    }
}
