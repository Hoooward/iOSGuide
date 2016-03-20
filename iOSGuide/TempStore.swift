//
//  Temp.swift
//  iOSGuide
//
//  Created by Howard on 3/20/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class Temp: NSObject, NSCoding {
    
    // MARK: - Propertire
    let fahrenheit: String!
    let centigrade: String!
    // MARK: - init
    
    init(fahrenheit: String, withConversion centigrade: String) {
        self.fahrenheit = fahrenheit
        self.centigrade = centigrade
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fahrenheit = aDecoder.decodeObjectForKey("fahrenheit") as! String
        centigrade = aDecoder.decodeObjectForKey("centigrade") as! String
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(fahrenheit, forKey: "fahrenheit")
        aCoder.encodeObject(centigrade, forKey: "centigrade")
    }
}

class TempStore {
    
    // MARK: - Properties
    var allTemps = [Temp]()
    
    // MARK: - init 
    init() {
        let archiveURL = NSURL.archiveURLWithEndPathComponent("temp")
        
        if let temps = NSKeyedUnarchiver.unarchiveObjectWithFile(archiveURL.path!) as? [Temp] {
            allTemps += temps
        }
        
    }
    
    // MARK: - Function
    func creatTemp(fahrenheit: String, withConversion centigrade: String) -> Temp {
        let newTemp = Temp(fahrenheit: fahrenheit, withConversion: centigrade)
        allTemps.append(newTemp)
        return newTemp
    }
    
    func deleteTemp(temp: Temp) {
        if let index = allTemps.indexOf(temp) {
            allTemps.removeAtIndex(index)
        }
    }
    
    func archivedURLWith() -> NSURL {
        let documentDirectorys = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documnetURL = documentDirectorys.first!
        
        return documnetURL.URLByAppendingPathComponent("temp.archive")
        
    }
    
    func saveTemps() -> Bool {
        let archiveURL = NSURL.archiveURLWithEndPathComponent("temp")
        print("save temps in the path: \(archiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allTemps, toFile: archiveURL.path!)
    }
    
    
}










