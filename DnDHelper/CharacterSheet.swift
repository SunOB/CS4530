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
    var delegate : CharacterSheetDelegate!
    private var name : UILabel?
    private var game : UILabel?
    private var gender : UILabel?
    private var alignment : UILabel?
    private var race : UILabel?
    private var background : UILabel?
    private var clarClass : UILabel?
    
    private var level : UILabel?
    private var exp : UILabel?
    private var tempHP : UILabel?
    private var curHP : UILabel?
    private var maxHP : UILabel?
    private var hitDieSize : UILabel?
    private var curHitDie : UILabel?
    private var totalHitDie : UILabel?
    private var ac : UILabel?
    
    private var initiative : UILabel?
    private var speed : UILabel?
    private var deathSavesFailed : UILabel?
    private var deathSavesSuceeded : UILabel?
    private var proficiency : UILabel?
    private var inspiration : UILabel?
    
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
        clarClass = UILabel()
        
        level = UILabel()
        exp = UILabel()
        tempHP = UILabel()
        curHP = UILabel()
        maxHP = UILabel()
        hitDieSize = UILabel()
        curHitDie = UILabel()
        totalHitDie = UILabel()
        ac = UILabel()
        
        initiative = UILabel()
        speed = UILabel()
        deathSavesFailed = UILabel()
        deathSavesSuceeded = UILabel()
        proficiency = UILabel()
        inspiration = UILabel()
        
        backstory = UIButton()
        spellbook = UIButton()
        
        backstory?.addTarget(self, action: #selector(backstoryButtonPressed), for: .touchUpInside)
        spellbook?.addTarget(self, action: #selector(spellbookButtonPressed), for: .touchUpInside)
        
        addSubview(name!)
        addSubview(game!)
        addSubview(gender!)
        addSubview(alignment!)
        addSubview(race!)
        addSubview(background!)
        addSubview(clarClass!)
        addSubview(level!)
        addSubview(exp!)
        addSubview(tempHP!)
        addSubview(curHP!)
        addSubview(maxHP!)
        addSubview(hitDieSize!)
        addSubview(curHitDie!)
        addSubview(totalHitDie!)
        addSubview(ac!)
        addSubview(initiative!)
        addSubview(speed!)
        addSubview(deathSavesFailed!)
        addSubview(deathSavesSuceeded!)
        addSubview(proficiency!)
        addSubview(inspiration!)
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
        
        name?.text = "Name: "
        game?.text = "Game: "
        
        var temp: CGRect
        //If the space is too small the text wont show up, need to add scaling
        (game!.frame, r) = r.divided(atDistance: h * 0.4, from: .minYEdge)

        
        //(temp, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)
        //(name!.frame, temp) = temp.divided(atDistance: w * 0.6, from: .minXEdge)
        //(game!.frame, temp) = temp.divided(atDistance: w * 0.4, from: .minXEdge)
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
