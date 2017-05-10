//
//  CompanySetting.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/26/17.
//
//

import Foundation

struct CompanySetting{
    private var opDays: [Int]
    private var washCap: Int
    private var range: [Int]
    
    init(opDays: [Int], washCap: Int, range: [Int]){
        self.opDays = opDays
        self.washCap = washCap
        self.range = range
    }
}

