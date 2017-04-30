//
//  Washer.swift
//  MobeWash
//
//  Created by 张子桐 on 4/21/17.
//
//

import Foundation


class Washer{
    //field
    private var _name:String!
    private var _phone:String!
    private var _workList:[Work]
    
    
    
    init(name:String) {
        self._name=name
        _phone = nil
        _workList=[Work]()
    }
    
    
    var name:String {
        return _name
    }
    
    var phone:String!{
        get{
            return _phone
        }
        set{
            self._phone=newValue
        }
        
    }
    
    var workList:[Work]{
        return _workList
    }
    
    func addWork(work:Work){
        if(work.isValid()){
            _workList.append(work)
        }
        update()
    }
    // update worklist in order
    func update(){
        
    }
    
    
    
    
    
}
