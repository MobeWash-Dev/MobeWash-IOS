//
//  Booking.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/27/17.
//
//

import Foundation

public class Booking {
    var calendarType: Int
    var appointmentTypeID: Int
    var datetime: String
    var firstName: String, lastName: String, email: String, phone: String
    var fields: [Field]
    
    init(calendarType: Int, appointmentTypeID: Int, dateTime: String, firstName: String,
         lastName: String, email: String, phone: String, fields: [Field]) {
        self.calendarType = calendarType
        self.appointmentTypeID = appointmentTypeID
        self.datetime = dateTime
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.fields = fields
    }
    
    func addField(field: Field) {
        self.fields.append(field)
    }
    
}
