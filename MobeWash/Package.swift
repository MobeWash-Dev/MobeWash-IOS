//
//  Services.swift
//  MobeWash
//
//  Created by Chad Lohrli on 4/26/17.
//
//  Package models MobeWash package information

import Foundation

public class Package {
    private var uid: String
    private var appointmentTypeID: String
    private var name: String
    private var cost: Double, extraCost: Double
    private var length: Int, extraLength: Int
    private var info: [String]
    
    //init for regular car
    public init(name: String, cost: Double, length: Int, info: [String]){
        self.uid = "ser_" + UUID().uuidString
        self.appointmentTypeID = "apt_" + UUID().uuidString
        self.name = name
        self.cost = cost
        self.length = length
        self.extraCost = 0.0
        self.extraLength = 0
        self.info = info
    }
    
    //init for larger car
    public convenience init(name: String, cost: Double, extraCost: Double,length: Int, extraLength: Int, info: [String]){
        self.init(name: name, cost: cost, length: length, info: info)
        self.extraCost = extraCost
        self.extraLength = extraLength
        self.info = info
    }
    
    //init from dictionary
    public init(dictionary: NSDictionary){
        self.uid = dictionary["uid"] as! String
        self.appointmentTypeID = dictionary["appointmentTypeID"] as! String
        self.name = dictionary["name"] as! String
        self.cost = dictionary["cost"] as! Double
        self.length = dictionary["length"] as! Int
        self.extraCost = dictionary["extraCost"] as! Double
        self.extraLength = dictionary["extraLength"] as! Int
        self.info = dictionary["info"] as! [String]
    }
    
    
    //getters
    var getName:String{
        get{ return name }
    }
    
    var getCost:Double{
        get { return cost }
    }
    
    var getExtraCost:Double{
        get{ return extraCost }
    }
    
    var getLength:Int{
        get{ return length }
    }
    
    var getExtraLength:Int{
        get{ return extraLength }
    }
    
    var getInfo:[String]{
        get{ return info }
    }
    
    
    //returns a dictionary representation of the object
    public func toDictionary() -> NSDictionary {
        let dictionary: NSMutableDictionary = [:]
        
        dictionary.setValue(self.uid, forKey: "uid")
        dictionary.setValue(self.appointmentTypeID, forKey: "appointmentTypeID")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.cost, forKey: "cost")
        dictionary.setValue(self.extraCost, forKey: "extraCost")
        dictionary.setValue(self.length, forKey: "length")
        dictionary.setValue(self.extraLength, forKey: "extraLength")
        dictionary.setValue(self.info, forKey: "info")
        
        return dictionary
    }

    //serialize object data to json
    public func toJson() -> Data? {
        var jsonData: Data?
        
        do{
            jsonData = try JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted)
        }catch{
            print("Error with serialization")
            print(LocalizedError.self)
        }
        
        return jsonData
    }
    
}
