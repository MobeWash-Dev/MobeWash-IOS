//
//  Card.swift
//  MobeWash
//
//  Created by Chad Lohrli on 5/27/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation

public class Card {
    private var calendarType: Int
    private var appointmentTypeID: String
    private var datetime: String
    private var firstName: String, lastName: String, email: String, phone: String
    private var fields: [Field]
    
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
