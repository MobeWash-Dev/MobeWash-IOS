//
//  MWFields.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/27/17.
//
//

import Foundation

public struct MWField {
    public var _id : String
    public var _name : String
    public var _value : String
    
    init(name:String,value:String){
        
        self._id = UUID().uuidString
        self._name = name
        self._value = value
        
    }
    

}
