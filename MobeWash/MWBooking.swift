//
//  MWBooking.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/27/17.
//
//

import Foundation

public class MWBooking {
    
    public var _calendarType : Int
    public var _appointmentTypeID : String
    public var _datetime : String
    public var _firstName : String
    public var _lastName : String
    public var _email : String
    public var _phone : String
    public var _fields : [MWField]
    
    
    init(calendarType:Int,appointmentTypeID:String,dateTime:String,firstName:String,
         lasName:String,email:String,phone:String,fields:[MWField]) {
        
        self._calendarType = calendarType
        self._appointmentTypeID = appointmentTypeID
        self._datetime = dateTime
        self._firstName = firstName
        self._lastName = lasName
        self._email = email
        self._phone = phone
        self._fields = fields
        
        
    }
    
    func addField(field: MWField) {
        self._fields.append(field)
    }
    
}
