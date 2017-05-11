//
//  Washer.swift
//  MobeWash
//
//  Created by 张子桐 on 4/21/17.
//
//

import Foundation

class Washer{
    private(set) var name: String!
    private(set) var phone: String!
    private(set) var workList: [Work]
    
    init(name: String) {
        self.name = name
        self.phone = nil
        self.workList = [Work]()
    }
    
    func addWork(work: Work) {
        if work.isValid() {
            workList.append(work)
        }
        update()
    }

    func update(){
        //TODO
    }
    
}
