//
//  Backstory.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Backstory : NSObject, NSCoding {
    var charBackstory : String
    var allies : String
    var featsAndTraits : String
    var treasure : String
    
    override init() {
        charBackstory = ""
        allies = ""
        featsAndTraits = ""
        treasure = ""
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(charBackstory, forKey: "CharBackstory")
        aCoder.encode(allies, forKey: "Allies")
        aCoder.encode(featsAndTraits, forKey: "FeatsAndTraits")
        aCoder.encode(treasure, forKey: "Treasure")
        
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        charBackstory = aDecoder.decodeObject(forKey: "Backstory") as! String
        allies = aDecoder.decodeObject(forKey: "Allies") as! String
        featsAndTraits = aDecoder.decodeObject(forKey: "FeatsAndTraits") as! String
        treasure = aDecoder.decodeObject(forKey: "Treasure") as! String

    }
}
