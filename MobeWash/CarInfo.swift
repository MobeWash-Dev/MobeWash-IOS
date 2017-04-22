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
    private var _carMake:String
    private var _carColor:String
    private var _carPlate:String
    private var _carModel:String
    private var _carPicture:[String]
    
    //init
    
    init(carMake:String, carColor:String,carPlate:String,carModel:String,carPicture:[String] ) {
        self._carMake=carMake
        self._carColor = carColor
        self._carPlate=carPlate
        self._carModel=carModel
        self._carPicture=carPicture
    }
}
