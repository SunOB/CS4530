//
//  Combatant.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Combatant: NSObject, NSCoding {
    var name : String
    var ac : Int
    var hp : Int
    var pg : Int
    public var initiative : Int
    
    override init() {
        name = ""
        ac = 0
        hp = 0
        pg = 0
        initiative = 0
        super.init()
    }
    
    init(_name : String, _ac : Int, _hp: Int, _pg : Int) {
        name = _name
        ac = _ac
        hp = _hp
        pg = _pg
        initiative = 0
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(ac, forKey: "AC")
        aCoder.encode(hp, forKey: "HP")
        aCoder.encode(pg, forKey: "PG")
        aCoder.encode(initiative, forKey: "Initiative")
        
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        ac = aDecoder.decodeInteger(forKey: "AC")
        hp = aDecoder.decodeInteger(forKey: "HP")
        pg = aDecoder.decodeInteger(forKey: "PG")
        initiative = aDecoder.decodeInteger(forKey: "Initiative")
    }
}
