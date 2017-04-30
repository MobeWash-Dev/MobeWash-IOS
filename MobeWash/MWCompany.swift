//
//  MWCompany.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/26/17.
//
//

import Foundation

public class MWCompany {
    
    private var _uid : String
    private var _name : String
    private var _location : String
    private var _setting : MWCompanySetting
    private var _months : [String]
    
    init(name:String,location:String,setting:MWCompanySetting,months:[String]){
        
        self._uid = UUID().uuidString
        self._name = name
        self._location = location
        self._setting = setting
        self._months = months
        
        
    }

}
