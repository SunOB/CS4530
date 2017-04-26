//
//  DungeonMaster.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class DungeonMaster: NSObject, NSCoding {
    var campaigns : [Campaign]
    var bestiary : [BestiaryEntry]
    var soundboard : [Sound]
    
    override init() {
        campaigns = []
        bestiary = []
        soundboard = []
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(campaigns, forKey: "Campaigns")
        aCoder.encode(bestiary, forKey: "Bestiary")
        aCoder.encode(soundboard, forKey: "Soundboard")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        campaigns = aDecoder.decodeObject(forKey: "Campaigns") as! [Campaign]
        bestiary = aDecoder.decodeObject(forKey: "Bestiary") as! [BestiaryEntry]
        soundboard = aDecoder.decodeObject(forKey: "Soundboard") as! [Sound]
    }
}
