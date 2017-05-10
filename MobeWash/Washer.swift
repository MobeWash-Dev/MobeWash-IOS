//
//  Washer.swift
//  MobeWash
//
//  Created by 张子桐 on 4/21/17.
//
//

import Foundation

class Washer{
    private var name: String!
    private var phone: String!
    private var workList: [Work]
    
    init(name: String) {
        self.name = name
        self.phone = nil
        self.workList = [Work]()
    }
    
    var getName: String {
        return name
    }
    
    var getPhone: String! {
        get{
            return phone
        }
        set{
            self.phone = newValue
        }
        
    }
    
    var getWorkList: [Work] {
        return workList
    }
    
    func addWork(work: Work) {
        if work.isValid() {
            workList.append(work)
        }
        update()
    }
    // update worklist in order
    func update(){
        
    }
    
}
