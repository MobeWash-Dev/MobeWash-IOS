//
//  Services.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/26/17.
//
//  MWPackage models MobeWash package information

import Foundation

public class MWPackage {
    private var _uid : String
    private var _appointmentTypeID : String
    private var _name : String
    private var _cost : Double
    private var _extraCost : Double
    private var _length : Int
    private var _extraLength : Int
    private var _info : [String]
    
    
    //init for regular car
    public init(name:String,cost:Double,length:Int,info:[String]){
        
        self._uid = "ser_" + UUID().uuidString
        self._appointmentTypeID = "apt_" + UUID().uuidString
        self._name = name
        self._cost = cost
        self._length = length
        
        self._extraCost = 0.0
        self._extraLength = 0
        self._info = info
        
    }
    
    //init for larger car
    public convenience init(name:String,cost:Double,extraCost:Double,length:Int,extraLength:Int,info:[String]){
        
        self.init(name: name, cost: cost, length: length, info: info)
        
        self._extraCost = extraCost
        self._extraLength = extraLength
        self._info = info
        
    }
    
    //init from dictionary
    public init(dictionary: NSDictionary){
        
        self._uid = dictionary["uid"] as! String
        self._appointmentTypeID = dictionary["appointmentTypeID"] as! String
        self._name = dictionary["name"] as! String
        self._cost = dictionary["cost"] as! Double
        self._length = dictionary["length"] as! Int
        
        self._extraCost = dictionary["extraCost"] as! Double
        self._extraLength = dictionary["extraLength"] as! Int
        self._info = dictionary["info"] as! [String]
        
    }
    
    
    //getters
    var name:String{
        get{ return _name }
    }
    
    var cost:Double{
        get { return _cost }
    }
    
    var extraCost:Double{
        get{ return _extraCost }
    }
    
    var length:Int{
        get{ return _length }
    }
    
    var extraLength:Int{
        get{ return _extraLength }
    }
    
    var info:[String]{
        get{ return _info }
    }
    
    
    //returns a dictionary representation of the object
    public func toDictionary() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._uid, forKey: "uid")
        dictionary.setValue(self._appointmentTypeID, forKey: "appointmentTypeID")
        dictionary.setValue(self._name, forKey: "name")
        dictionary.setValue(self._cost, forKey: "cost")
        dictionary.setValue(self._extraCost, forKey: "extraCost")
        dictionary.setValue(self._length, forKey: "length")
        dictionary.setValue(self._extraLength, forKey: "extraLength")
        dictionary.setValue(self._info, forKey: "info")
        
        return dictionary
        
    }

    //serialize object data to json
    public func toJson() -> Data? {
       
        var jsonData:Data?
        
        do{
            jsonData = try JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted)
        }catch{
            print("Error with serialization")
            print(LocalizedError.self)
        }
        
        return jsonData
    }
    
}
