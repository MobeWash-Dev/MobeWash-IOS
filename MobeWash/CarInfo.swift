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
    //field
    private var _carMake:String!
    private var _carColor:String!
    private var _carPlate:String!
    private var _carModel:String!
    private var _carPicture:String!
    private var _ownerPhone:String!
    
    //init
    
    init(carMake:String, carColor:String,carPlate:String,carModel:String,carPicture:String,ownerPhone:String ) {
        self._carMake=carMake
        self._carColor = carColor
        self._carPlate=carPlate
        self._carModel=carModel
        self._carPicture=carPicture
        self._ownerPhone=ownerPhone
    }
    var carMake:String{
        return _carMake
    }
    var carColor:String!{
        return _carColor
    }
    var carPlate:String{
        return _carPlate
    }
    var carModel:String{
        return _carModel
    }
    var carPicture:String{
        return _carPicture
    }
    var ownerPhone:String{
        return _ownerPhone
    }
}
