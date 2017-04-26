//
//  Spellbook.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Spell : NSObject, NSCoding {
    var spellName : String
    var spellDesc : String
    var isPrepared : Bool
    
    override init () {
        spellName = ""
        spellDesc = ""
        isPrepared = false
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(spellName, forKey: "SpellName")
        aCoder.encode(spellDesc, forKey: "SpellDesc")
        aCoder.encode(isPrepared, forKey: "IsPrepared")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        spellName = aDecoder.decodeObject(forKey: "SpellName") as! String
        spellDesc = aDecoder.decodeObject(forKey: "SpellDesc") as! String
        isPrepared = aDecoder.decodeBool(forKey: "IsPrepared")
    }
}


class Spellbook: NSObject, NSCoding {
    var spellcastingClass : String
    var spellcastingAbility : String
    var spellAttackBonus : Int
    var spellSaveDC : Int
    
    var spellSlotsCur : [Int]
    var spellSlotsTotal : [Int]
    var spells : [[Spell]]
    
    
    override init() {
        spellcastingClass = ""
        spellcastingAbility = ""
        spellAttackBonus = 0
        spellSaveDC = 0
        
        spellSlotsCur = [0,0,0,0,0,0,0,0,0,0]
        spellSlotsTotal = [0,0,0,0,0,0,0,0,0,0]
        spells = [[],[],[],[],[],[],[],[],[],[]]
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(spellcastingClass, forKey: "SpellcastingClass")
        aCoder.encode(spellcastingAbility, forKey: "SpellcastingAbility")
        aCoder.encode(spellAttackBonus, forKey: "SpellAttackBonus")
        aCoder.encode(spellSaveDC, forKey: "SpellSaveDC")
        aCoder.encode(spellSlotsCur, forKey: "SpellSlotsCur")
        aCoder.encode(spellSlotsTotal, forKey: "SpellSlotsTotal")
        aCoder.encode(spells, forKey: "Spells")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        spellcastingClass = aDecoder.decodeObject(forKey: "SpellcastingClass") as! String
        spellcastingAbility = aDecoder.decodeObject(forKey: "SpellcastingAbility") as! String
        spellAttackBonus = aDecoder.decodeInteger(forKey: "SpellAttackBonus")
        spellSaveDC = aDecoder.decodeInteger(forKey: "SpellSaveDC")
        spellSlotsCur = aDecoder.decodeObject(forKey: "SpellSlotsCur") as! [Int]
        spellSlotsTotal = aDecoder.decodeObject(forKey: "SpellSlotsTotal") as! [Int]
        spells = aDecoder.decodeObject(forKey: "Spells") as! [[Spell]]

    }
}
