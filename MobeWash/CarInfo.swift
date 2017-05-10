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
    private var carMake: String!
    private var carColor: String!
    private var carPlate: String!
    private var carModel: String!
    private var carPicture: String!
    private var ownerPhone: String!

    init(carMake: String, carColor: String, carPlate: String, carModel: String, carPicture: String, ownerPhone: String ) {
        self.carMake = carMake
        self.carColor = carColor
        self.carPlate = carPlate
        self.carModel = carModel
        self.carPicture = carPicture
        self.ownerPhone = ownerPhone
    }
    
    var getCarMake: String{
        return carMake
    }
    
    var getCarColor: String!{
        return carColor
    }
    
    var getCarPlate: String{
        return carPlate
    }
    
    var getCarModel: String{
        return carModel
    }
    
    var getCarPicture: String{
        return carPicture
    }
    
    var getOwnerPhone: String{
        return ownerPhone
    }
}
