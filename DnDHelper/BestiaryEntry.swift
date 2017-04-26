//
//  BestiaryEntry.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class BestiaryEntry: NSObject, NSCoding {
    var name : String
    var ac : Int
    var hp : Int
    var pg : Int
    
    override init() {
        name = ""
        ac = 0
        hp = 0
        pg = 0
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(ac, forKey: "AC")
        aCoder.encode(hp, forKey: "HP")
        aCoder.encode(pg, forKey: "PG")
        
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        ac = aDecoder.decodeInteger(forKey: "AC")
        hp = aDecoder.decodeInteger(forKey: "HP")
        pg = aDecoder.decodeInteger(forKey: "PG")
        
    }
}
