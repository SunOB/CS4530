//
//  Character.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Attack: NSObject, NSCoding {
    var name : String
    var attackBonus : Int
    var damageDie : Int
    var damageDieCount : Int
    var damageBonus : Int
    var type : String
    var bonusEffects : String
    
    override init() {
        name = "Attack"
        attackBonus = 0
        damageDie = 0
        damageDieCount = 0
        damageBonus = 0
        type = "Type"
        bonusEffects = "Other Effects"
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(attackBonus, forKey: "AttackBonus")
        aCoder.encode(damageDie, forKey: "DmgDie")
        aCoder.encode(damageDieCount, forKey: "DmgDieCount")
        aCoder.encode(damageBonus, forKey: "DamageBonus")
        aCoder.encode(type, forKey: "Type")
        aCoder.encode(bonusEffects, forKey: "BonusEffects")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        attackBonus = aDecoder.decodeInteger(forKey: "AttackBonus")
        damageDie = aDecoder.decodeInteger( forKey: "DmgDie")
        damageDieCount = aDecoder.decodeInteger(forKey: "DmgDieCount")
        damageBonus = aDecoder.decodeInteger(forKey: "DamageBonus")
        type = aDecoder.decodeObject(forKey: "Type") as! String
        bonusEffects = aDecoder.decodeObject(forKey: "BonusEffects") as! String
    }
}

class Character: NSObject, NSCoding {
    var game : String
    var name : String
    var gender : String
    var alignment : String
    var race : String
    var background : String
    var charClass : String
    
    var level : Int
    var exp : Int
    var tempHP : Int
    var curHP : Int
    var maxHP : Int
    var hitDieSize : Int
    var curHitDie : Int
    var totalHitDie : Int
    var ac : Int
    var initiative : Int
    var speed : String
    var deathSavesFailed : Int
    var deathSavesSuceeded : Int
    var proficiency : Int
    var inspiration : Int
    
    let attributeLabels : [String] = ["Strength", "Dexterity", "Constitution", "Intelligence", "Wisdom", "Charisma"]
    var attributes : [Int]
    var savingThrows : [Int]
    var savingThrowProficiencies : [Bool]
    
    let skillLabels : [String] = ["Acrobatics (Dex)", "Animal Handling (Wis)", "Arcana (Int)", "Athletics (Str)", "Deception (Cha)", "History (Int)", "Insight (Wis)", "Intimidation (Cha)", "Investigation (Int)", "Medicine (Wis)", "Nature (Int)", "Perception (Wis)", "Performance (Cha)", "Persuasion (Cha)", "Religion (Int)", "Sleight of Hand (Dex)", "Stealth (Dex)", "Survival (Wis)"]
    var skills : [Int]
    var skillProficiencies : [Bool]
    
    var attacks : [Attack]
    var featsTraits : String
    var equipment : String
    
    var currency : [Int]
    
    var spellbook : Spellbook
    var backstory : Backstory
    
    override init() {
        game = ""
        name = ""
        gender = ""
        alignment = ""
        race = ""
        background = ""
        charClass = ""
        
        level = 0
        exp = 0
        tempHP = 0
        curHP = 0
        maxHP = 0
        hitDieSize = 0
        curHitDie = 0
        totalHitDie = 0
        ac = 0
        initiative = 0
        speed = ""
        deathSavesFailed = 0
        deathSavesSuceeded = 0
        proficiency = 0
        inspiration = 0
        
        attributes = [0,0,0,0,0,0]
        savingThrows = [0,0,0,0,0,0]
        savingThrowProficiencies = [false, false, false, false, false, false]
        skills = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        skillProficiencies = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
        
        attacks = []
        featsTraits = ""
        equipment = ""
        
        currency = [0,0,0,0,0]
        
        spellbook = Spellbook()
        backstory  = Backstory()
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(game, forKey: "Game")
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(gender, forKey: "Gender")
        aCoder.encode(alignment, forKey: "Alignment")
        aCoder.encode(race, forKey: "Race")
        aCoder.encode(background, forKey: "Background")
        aCoder.encode(charClass, forKey: "CharClass")
        
        aCoder.encode(level, forKey: "Level")
        aCoder.encode(exp, forKey: "Exp")
        aCoder.encode(tempHP, forKey: "TempHP")
        aCoder.encode(curHP, forKey: "CurHP")
        aCoder.encode(maxHP, forKey: "MaxHP")
        aCoder.encode(hitDieSize, forKey: "HitDieSize")
        aCoder.encode(curHitDie, forKey: "CurHitDie")
        aCoder.encode(totalHitDie, forKey: "TotalHitDie")
        aCoder.encode(ac, forKey: "AC")
        aCoder.encode(initiative, forKey: "Initiative")
        aCoder.encode(speed, forKey: "Speed")
        aCoder.encode(deathSavesFailed, forKey: "DeathSavesFailed")
        aCoder.encode(deathSavesSuceeded, forKey: "DeathSavesSuceeded")
        aCoder.encode(proficiency, forKey: "Proficiency")
        aCoder.encode(inspiration, forKey: "Inspiration")
        
        aCoder.encode(attributes, forKey: "Attributes")
        aCoder.encode(savingThrows, forKey: "SavingThrows")
        aCoder.encode(savingThrowProficiencies, forKey: "SavingThrowProficiencies")
        aCoder.encode(skills, forKey: "Skills")
        aCoder.encode(skillProficiencies, forKey: "SkillProficiencies")
        aCoder.encode(attacks, forKey: "Attacks")
        aCoder.encode(featsTraits, forKey: "FeatsTraits")
        aCoder.encode(equipment, forKey: "Equipment")
        aCoder.encode(currency, forKey: "Currency")
        aCoder.encode(spellbook, forKey: "Spellbook")
        aCoder.encode(backstory, forKey: "Backstory")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        game = aDecoder.decodeObject(forKey: "Game") as! String
        name = aDecoder.decodeObject(forKey: "Name") as! String
        gender = aDecoder.decodeObject(forKey: "Gender") as! String
        alignment = aDecoder.decodeObject(forKey: "Alignment") as! String
        race = aDecoder.decodeObject(forKey: "Race") as! String
        background = aDecoder.decodeObject(forKey: "Background") as! String
        charClass = aDecoder.decodeObject(forKey: "CharClass") as! String
        
        level = aDecoder.decodeInteger( forKey: "Level")
        exp = aDecoder.decodeInteger( forKey: "Exp")
        tempHP = aDecoder.decodeInteger( forKey: "TempHP")
        curHP = aDecoder.decodeInteger( forKey: "CurHP")
        maxHP = aDecoder.decodeInteger( forKey: "MaxHP")
        hitDieSize = aDecoder.decodeInteger( forKey: "HitDieSize")
        curHitDie = aDecoder.decodeInteger( forKey: "CurHitDie")
        totalHitDie = aDecoder.decodeInteger( forKey: "TotalHitDie")
        ac = aDecoder.decodeInteger( forKey: "AC")
        initiative = aDecoder.decodeInteger( forKey: "Initiative")
        speed = aDecoder.decodeObject( forKey: "Speed") as! String
        deathSavesFailed = aDecoder.decodeInteger( forKey: "DeathSavesFailed")
        deathSavesSuceeded = aDecoder.decodeInteger( forKey: "DeathSavesSuceeded")
        proficiency = aDecoder.decodeInteger( forKey: "Proficiency")
        inspiration = aDecoder.decodeInteger( forKey: "Inspiration")
        
        attributes = aDecoder.decodeObject(forKey: "Attributes") as! [Int]
        savingThrows = aDecoder.decodeObject(forKey: "SavingThrows") as! [Int]
        savingThrowProficiencies = aDecoder.decodeObject(forKey: "SavingThrowProficiencies") as! [Bool]
        skills = aDecoder.decodeObject(forKey: "Skills") as! [Int]
        skillProficiencies = aDecoder.decodeObject(forKey: "SkillProficiencies") as! [Bool]
        
        attacks = aDecoder.decodeObject(forKey: "Attacks") as! [Attack]
        featsTraits = aDecoder.decodeObject(forKey: "FeatsTraits") as! String
        equipment = aDecoder.decodeObject(forKey: "Equipment") as! String
        
        currency = aDecoder.decodeObject(forKey: "Currency") as! [Int]
        
        spellbook = aDecoder.decodeObject(forKey: "Spellbook") as! Spellbook
        backstory = aDecoder.decodeObject(forKey: "Backstory") as! Backstory
    }
}
