//
//  Encounter.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

protocol ModuleContent {
}

class Encounter: NSObject, NSCoding, ModuleContent {
    var name : String
    var combatants : [Combatant]
    
    var combatantText : String {
        var ret = ""
        var combatantCounts : [String: Int] = [:]
        
        for c in combatants {
            if var count = combatantCounts[c.name] {
                count = count + 1
            }
            else {
                combatantCounts[c.name] = 1
            }
        }
        
        for combatantCount in combatantCounts {
            ret += String(combatantCount.value) + "x " + combatantCount.key + ", "
        }
        
        if ret.characters.count >= 2 {
            ret = ret.substring(to: ret.index(ret.endIndex, offsetBy: -2))
        }
        return ret
    }
    
    override init() {
        name = ""
        combatants = []
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(combatants, forKey: "Combatants")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        combatants = aDecoder.decodeObject(forKey: "Combatants") as! [Combatant]
    }
    
    func sortByInitiative() {
        combatants.sort(by: {$0.initiative > $1.initiative})
    }
    
    func addCombatants(character: BestiaryEntry, count: Int) {
        if (count > 0) {
            for _ in 1...count {
                let c = Combatant(_name: character.name, _ac: character.ac, _hp: character.hp, _pg: character.pg)
                combatants.append(c);
            }
        }
    }
}
