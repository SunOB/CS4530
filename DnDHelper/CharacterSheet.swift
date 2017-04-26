//
//  CharacterSheet.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol CharacterSheetDelegate {
    func backstoryPressed(sender: UIButton!)
    func spellbookPressed(sender: UIButton!)
}

class CharacterSheet : UIView {
    let fontSize : CGFloat = 7.5
    var delegate : CharacterSheetDelegate!
    
    //Labels
    private var name : UILabel?
    private var game : UILabel?
    private var gender : UILabel?
    private var alignment : UILabel?
    private var race : UILabel?
    private var background : UILabel?
    private var charClass : UILabel?
    
    private var level : UILabel?
    private var exp : UILabel?
    private var tempHP : UILabel?
    private var hp : UILabel?
    private var hpSlash : UILabel?
    private var hitDie : UILabel?
    private var hitDieD : UILabel?
    private var hitDieSlash : UILabel?
    private var ac : UILabel?
    
    private var initiative : UILabel?
    private var speed : UILabel?
    private var deathSaves: UILabel?
    private var proficiency : UILabel?
    private var inspiration : UILabel?
    
    private var attacks : UILabel?
    private var featsAndFeatures : UILabel?
    private var equipment : UILabel?
    
    //Text Fields
    private var nameText : UITextField?
    private var gameText : UITextField?
    private var genderText : UITextField?
    private var alignmentText : UITextField?
    private var raceText : UITextField?
    private var backgroundText : UITextField?
    private var charClassText : UITextField?
    
    private var levelText : UITextField?
    private var expText : UITextField?
    private var tempHPText : UITextField?
    private var curHPText : UITextField?
    private var maxHPText : UITextField?
    private var hitDieSizeText : UITextField?
    private var curHitDieText : UITextField?
    private var totalHitDieText : UITextField?
    private var acText : UITextField?
    
    private var initiativeText : UITextField?
    private var speedText : UITextField?
    private var proficiencyText : UITextField?
    private var inspirationText : UITextField?
    
    private var attacksText : UITextField?
    private var featsAndFeaturesText : UITextField?
    private var equipmentText : UITextField?
    
    private var backstory : UIButton?
    private var spellbook : UIButton?
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        name = UILabel()
        game = UILabel()
        gender = UILabel()
        alignment = UILabel()
        race = UILabel()
        background = UILabel()
        charClass = UILabel()
        
        level = UILabel()
        exp = UILabel()
        tempHP = UILabel()
        hp = UILabel()
        hpSlash = UILabel()
        hitDie = UILabel()
        hitDieD = UILabel()
        hitDieSlash = UILabel()
        ac = UILabel()
        
        initiative = UILabel()
        speed = UILabel()
        deathSaves = UILabel()
        proficiency = UILabel()
        inspiration = UILabel()
        
        nameText = UITextField()
        gameText = UITextField()
        genderText = UITextField()
        alignmentText = UITextField()
        raceText = UITextField()
        backgroundText = UITextField()
        charClassText = UITextField()
        
        levelText = UITextField()
        expText = UITextField()
        tempHPText = UITextField()
        curHPText = UITextField()
        maxHPText = UITextField()
        hitDieSizeText = UITextField()
        curHitDieText = UITextField()
        totalHitDieText = UITextField()
        acText = UITextField()
        
        initiativeText = UITextField()
        speedText = UITextField()
        proficiencyText = UITextField()
        inspirationText = UITextField()
        
        backstory = UIButton()
        spellbook = UIButton()
        
        backstory?.addTarget(self, action: #selector(backstoryButtonPressed), for: .touchUpInside)
        spellbook?.addTarget(self, action: #selector(spellbookButtonPressed), for: .touchUpInside)
        
        name?.font = UIFont(name: "Helvetica", size: fontSize)
        game?.font = UIFont(name: "Helvetica", size: fontSize)
        gender?.font = UIFont(name: "Helvetica", size: fontSize)
        alignment?.font = UIFont(name: "Helvetica", size: fontSize)
        race?.font = UIFont(name: "Helvetica", size: fontSize)
        background?.font = UIFont(name: "Helvetica", size: fontSize)
        charClass?.font = UIFont(name: "Helvetica", size: fontSize)
        level?.font = UIFont(name: "Helvetica", size: fontSize)
        exp?.font = UIFont(name: "Helvetica", size: fontSize)
        tempHP?.font = UIFont(name: "Helvetica", size: fontSize)
        hp?.font = UIFont(name: "Helvetica", size: fontSize)
        hpSlash?.font = UIFont(name: "Helvetica", size: fontSize * 2)
        hitDie?.font = UIFont(name: "Helvetica", size: fontSize)
        hitDieD?.font = UIFont(name: "Helvetica", size: fontSize * 2)
        hitDieSlash?.font = UIFont(name: "Helvetica", size: fontSize * 2)
        ac?.font = UIFont(name: "Helvetica", size: fontSize)
        initiative?.font = UIFont(name: "Helvetica", size: fontSize)
        speed?.font = UIFont(name: "Helvetica", size: fontSize)
        deathSaves?.font = UIFont(name: "Helvetica", size: fontSize)
        proficiency?.font = UIFont(name: "Helvetica", size: fontSize)
        inspiration?.font = UIFont(name: "Helvetica", size: fontSize)

        nameText?.borderStyle = UITextBorderStyle.bezel
        gameText?.borderStyle = UITextBorderStyle.bezel
        genderText?.borderStyle = UITextBorderStyle.bezel
        alignmentText?.borderStyle = UITextBorderStyle.bezel
        raceText?.borderStyle = UITextBorderStyle.bezel
        charClassText?.borderStyle = UITextBorderStyle.bezel
        backgroundText?.borderStyle = UITextBorderStyle.bezel
        levelText?.borderStyle = UITextBorderStyle.bezel
        expText?.borderStyle = UITextBorderStyle.bezel
        tempHPText?.borderStyle = UITextBorderStyle.bezel
        curHPText?.borderStyle = UITextBorderStyle.bezel
        maxHPText?.borderStyle = UITextBorderStyle.bezel
        hitDieSizeText?.borderStyle = UITextBorderStyle.bezel
        genderText?.borderStyle = UITextBorderStyle.bezel
        curHitDieText?.borderStyle = UITextBorderStyle.bezel
        totalHitDieText?.borderStyle = UITextBorderStyle.bezel
        acText?.borderStyle = UITextBorderStyle.bezel
        initiativeText?.borderStyle = UITextBorderStyle.bezel
        speedText?.borderStyle = UITextBorderStyle.bezel
        proficiencyText?.borderStyle = UITextBorderStyle.bezel
        inspirationText?.borderStyle = UITextBorderStyle.bezel
        
        addSubview(name!)
        addSubview(game!)
        addSubview(gender!)
        addSubview(alignment!)
        addSubview(race!)
        addSubview(background!)
        addSubview(charClass!)
        addSubview(level!)
        addSubview(exp!)
        addSubview(tempHP!)
        addSubview(hp!)
        addSubview(hpSlash!)
        addSubview(hitDie!)
        addSubview(hitDieD!)
        addSubview(hitDieSlash!)
        addSubview(ac!)
        addSubview(initiative!)
        addSubview(speed!)
        addSubview(deathSaves!)
        addSubview(proficiency!)
        addSubview(inspiration!)
        
        addSubview(nameText!)
        addSubview(gameText!)
        addSubview(genderText!)
        addSubview(alignmentText!)
        addSubview(raceText!)
        addSubview(backgroundText!)
        addSubview(charClassText!)
        addSubview(levelText!)
        addSubview(expText!)
        addSubview(tempHPText!)
        addSubview(curHPText!)
        addSubview(maxHPText!)
        addSubview(hitDieSizeText!)
        addSubview(curHitDieText!)
        addSubview(totalHitDieText!)
        addSubview(acText!)
        addSubview(initiativeText!)
        addSubview(speedText!)
        addSubview(proficiencyText!)
        addSubview(inspirationText!)
        
        addSubview(backstory!)
        addSubview(spellbook!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        name?.text = "   Name: "
        game?.text = " Game: "
        gender?.text = " Gender: "
        alignment?.text = " Alignment: "
        race?.text = " Race: "
        
        background?.text = "Background: "
        charClass?.text = " Class: "
        level?.text = " Level: "
        exp?.text = "  Exp: "
        tempHP?.text = " Temporary HP: "
        hp?.text = " HP: "
        hpSlash?.text = " /"
        
        hitDie?.text = " Hit Die: "
        hitDieD?.text = " d"
        hitDieSlash?.text = " / "
        ac?.text = " AC: "
        initiative?.text = " Initiative: "
        speed?.text = " Speed: "
        deathSaves?.text = " Death Saves: "
        
        proficiency?.text = " Proficiency: "
        inspiration?.text = "  Inspiration: "
        
        var temp: CGRect
        var temp2: CGRect
        var temp3: CGRect
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (name!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (nameText!.frame, temp) = temp.divided(atDistance: w * 0.5, from: .minXEdge)
        (game!.frame, temp) = temp.divided(atDistance: w * 0.09, from: .minXEdge)
        (gameText!.frame, temp) = temp.divided(atDistance: w * 0.28, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (gender!.frame, temp) = temp.divided(atDistance: w * 0.10, from: .minXEdge)
        (genderText!.frame, temp) = temp.divided(atDistance: w * 0.25, from: .minXEdge)
        (alignment!.frame, temp) = temp.divided(atDistance: w * 0.13, from: .minXEdge)
        (alignmentText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (race!.frame, temp) = temp.divided(atDistance: w * 0.075, from: .minXEdge)
        (raceText!.frame, temp) = temp.divided(atDistance: w * 0.335, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (_, temp) = temp.divided(atDistance: w * 0.02, from: .minXEdge)
        (background!.frame, temp) = temp.divided(atDistance: w * 0.15, from: .minXEdge)
        (backgroundText!.frame, temp) = temp.divided(atDistance: w * 0.25, from: .minXEdge)
        (inspiration!.frame, temp) = temp.divided(atDistance: w * 0.15, from: .minXEdge)
        (inspirationText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (exp!.frame, temp) = temp.divided(atDistance: w * 0.075, from: .minXEdge)
        (expText!.frame, temp) = temp.divided(atDistance: w * 0.20, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (_, temp) = temp.divided(atDistance: w * 0.02, from: .minXEdge)
        (level!.frame, temp) = temp.divided(atDistance: w * 0.08, from: .minXEdge)
        (levelText!.frame, temp) = temp.divided(atDistance: w * 0.15, from: .minXEdge)
        (charClass!.frame, temp) = temp.divided(atDistance: w * 0.08, from: .minXEdge)
        (charClassText!.frame, temp) = temp.divided(atDistance: w * 0.63, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.1, from: .minYEdge)
        
        (temp2, temp) = temp.divided(atDistance: w * 0.55, from: .minXEdge)
        (temp3, temp2) = temp2.divided(atDistance: h * 0.05, from: .minYEdge)
        
        (_, temp3) = temp3.divided(atDistance: w * 0.12, from: .minXEdge)
        (hp!.frame, temp3) = temp3.divided(atDistance: w * 0.05, from: .minXEdge)
        (curHPText!.frame, temp3) = temp3.divided(atDistance: w * 0.15, from: .minXEdge)
        (hpSlash!.frame, temp3) = temp3.divided(atDistance: w * 0.05, from: .minXEdge)
        (maxHPText!.frame, temp3) = temp3.divided(atDistance: w * 0.15, from: .minXEdge)
        
        (_, temp2) = temp2.divided(atDistance: h * 0.01, from: .minYEdge)
        (_, temp2) = temp2.divided(atDistance: w * 0.05, from: .minXEdge)
        (tempHP!.frame, temp2) = temp2.divided(atDistance: w * 0.2, from: .minXEdge)
        (tempHPText!.frame, temp2) = temp2.divided(atDistance: w * 0.15, from: .minXEdge)
        
        (hitDie!.frame, temp) = temp.divided(atDistance: w * 0.1 , from: .minXEdge)
        
        (temp2, temp) = temp.divided(atDistance: h * 0.05, from: .minYEdge)
        (hitDieD!.frame, temp2) = temp2.divided(atDistance: w * 0.05, from: .minXEdge)
        (hitDieSizeText!.frame, temp2) = temp2.divided(atDistance: w * 0.1, from: .minXEdge)
        
        (_, temp) = temp.divided(atDistance: h * 0.01, from: .minYEdge)
        (curHitDieText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (hitDieSlash!.frame, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        (totalHitDieText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (_, temp) = temp.divided(atDistance: h * 0.02, from: .minXEdge)
        (ac!.frame, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        (acText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (initiative!.frame, temp) = temp.divided(atDistance: w * 0.125, from: .minXEdge)
        (initiativeText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (speed!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (speedText!.frame, temp) = temp.divided(atDistance: w * 0.2, from: .minXEdge)
        (proficiency!.frame, temp) = temp.divided(atDistance: w * 0.14, from: .minXEdge)
        (proficiencyText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        
        
//        
//        background = UILabel()
//        charClass = UILabel()
//        
//        level = UILabel()
//        exp = UILabel()
//        hp = UILabel()
//        hitDie = UILabel()
//        ac = UILabel()
//        
//        initiative = UILabel()
//        speed = UILabel()
//        deathSaves = UILabel()
//        proficiency = UILabel()
//        inspiration = UILabel()
//        


//        backgroundText = UITextField()
//        charClassText = UITextField()
//        
//        levelText = UITextField()
//        expText = UITextField()
//        tempHPText = UITextField()
//        curHPText = UITextField()
//        maxHPText = UITextField()
//        hitDieSizeText = UITextField()
//        curHitDieText = UITextField()
//        totalHitDieText = UITextField()
//        acText = UITextField()
//        
//        initiativeText = UITextField()
//        speedText = UITextField()
//        proficiencyText = UITextField()
//        inspirationText = UITextField()

        
        
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func backstoryButtonPressed(sender: UIButton!) {
        delegate.backstoryPressed(sender: sender)
    }
    
    func spellbookButtonPressed(sender: UIButton!) {
        delegate.spellbookPressed(sender: sender)
    }
    
}
