//
//  Item.swift
//  iOSGuide
//
//  Created by Howard on 3/13/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumbner: String?
    var dateCreated: NSDate
    let itemKey: String
    
    // MARK: - Initalize
    init(name: String, serialNumber: String?, valueInDollars: Int) {
       
        self.name = name
        self.serialNumbner = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            /**
             arc4random_uniform 会返回一个从0到上界的随机整数,不包括上界.
             如果上界为2, 那么结果会是0, 1之间的随机数.就像投硬币一样
            */
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            
            /**
             UUID 是唯一通用标识符的缩写.
             NSUUID 类会生成随机字符串, like this: 68753A44-4D6F-1226-9C60-0050E4C00067.
            */
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            print("randomSerialNumber is = \(randomSerialNumber)")
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
        
    }
    
    // MARK: - Coding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        serialNumbner = aDecoder.decodeObjectForKey("serialNumber") as? String
        
        valueInDollars = aDecoder.decodeIntegerForKey("valueInDollars")
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeObject(serialNumbner, forKey: "serialNumber")
        
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars")
        
    }
}





















