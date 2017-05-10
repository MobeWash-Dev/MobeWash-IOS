//
//  Work.swift
//  MobeWash
//
//  Created by 张子桐 on 4/21/17.
//
//

import Foundation

class Work{
    private var workTitle: String!
    private var workTime: String!
    private var workLocation: String!
    private var package:String!
    private var carInfo:CarInfo!
    
    init(workTitle: String, workTime: String, workLoc: String, package: String, carInfo: CarInfo) {
        self.workTitle = workTitle
        self.workTime = workTime
        self.workLocation = workLoc
        self.package = package
        self.carInfo = carInfo
    }

    var getWorkTitle: String {
        return workTitle
    }
    
    var getWorkTime: String{
        get{
            return workTime
        }
        set{
            workTime = newValue
        }
    }
    
    var getWorkLocation:String{
        return workLocation
    }
    
    var getCarInfo:CarInfo{
        return carInfo
    }
    
    var getPackage:String{
        return package
    }
    
    func isValid() -> Bool{
        return true
    }
}
