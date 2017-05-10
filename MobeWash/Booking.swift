//
//  Booking.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/27/17.
//
//

import Foundation

public class Booking {
    public var calendarType: Int
    public var appointmentTypeID: String
    public var datetime: String
    public var firstName: String, lastName: String, email: String, phone: String
    public var fields: [Field]
    
    init(calendarType: Int, appointmentTypeID: String, dateTime: String, firstName: String,
         lasName: String, email: String, phone: String, fields: [Field]) {
        self.calendarType = calendarType
        self.appointmentTypeID = appointmentTypeID
        self.datetime = dateTime
        self.firstName = firstName
        self.lastName = lasName
        self.email = email
        self.phone = phone
        self.fields = fields
    }
    
    func addField(field: Field) {
        self.fields.append(field)
    }
    
}
