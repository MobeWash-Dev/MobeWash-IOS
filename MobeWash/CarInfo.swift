////
////  CarInfo.swift
////  MobeWash
////
////  Created by 张子桐 on 4/21/17.
////
////
//
import Foundation

class CarInfo{
    private(set) var carMake: String!
    private(set) var carColor: String!
    private(set) var carPlate: String!
    private(set) var carModel: String!
    private(set) var carPicture: String!
    private(set) var ownerPhone: String!

    init(carMake: String, carColor: String, carPlate: String, carModel: String, carPicture: String, ownerPhone: String ) {
        self.carMake = carMake
        self.carColor = carColor
        self.carPlate = carPlate
        self.carModel = carModel
        self.carPicture = carPicture
        self.ownerPhone = ownerPhone
    }    
}
