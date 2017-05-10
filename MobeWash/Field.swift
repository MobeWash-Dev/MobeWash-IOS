//
//  Field.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/27/17.
//
//

import Foundation

public struct Field {
    public var id: String
    public var name: String
    public var value: String
    
    init(name: String, value: String){
        self.id = UUID().uuidString
        self.name = name
        self.value = value
    }
}
