//
//  MWCompanySetting.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/26/17.
//
//

import Foundation

struct MWCompanySetting{
    
    private var _opDays: [Int]
    private var _washCap: Int
    private var _range: [Int]
    
    init(opDays:[Int],washCap:Int,range:[Int]){
        
        self._opDays = opDays
        self._washCap = washCap
        self._range = range
        
    }
    
}

