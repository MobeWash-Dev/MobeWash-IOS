//
//  Work.swift
//  MobeWash
//
//  Created by 张子桐 on 4/21/17.
//
//

import Foundation

class Work{
    private(set) var workTitle: String!
    private(set) var workTime: String!
    private(set) var workLocation: String!
    private(set) var package: String!
    private(set) var carInfo: CarInfo!
    
    init(workTitle: String, workTime: String, workLoc: String, package: String, carInfo: CarInfo) {
        self.workTitle = workTitle
        self.workTime = workTime
        self.workLocation = workLoc
        self.package = package
        self.carInfo = carInfo
    }

    func isValid() -> Bool{
        return true
    }
}
