//
//  SpellbookView.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol SpellbookViewDelegate {
    func addSpell(level: Int)
}

class SpellbookView : UIView, UITextFieldDelegate{
    var delegate : SpellbookViewDelegate!
    
    private var spellClass : UILabel?
    private var spellAbility : UILabel?
    private var spellAttackBonus : UILabel?
    private var spellSaveDC : UILabel?
    
    private var spellClassText : UITextField?
    private var spellAbilityText : UITextField?
    private var spellAttackBonusText : UITextField?
    private var spellSaveDCText : UITextField?
    
    private var spellLabels : [UILabel] = []
    private var spellButtons : [UIButton] = []
    private var spellSlotLabels : [UILabel] = []
    private var currentSlots : [UITextField] = []
    private var slashLabels : [UILabel] = []
    private var totalSlots : [UITextField] = []
    var spells : [UICollectionView] = []
    
    let fontSize : CGFloat = 7.5
    
    var _spellClass : String {
        return (spellClassText?.text)!
    }
    
    var _spellAbility : String {
        return (spellAbilityText!.text)!
    }
    
    var _spellAttackBonus : Int {
        if Int((spellAttackBonusText?.text!)!) == nil {
            return 0
        }
        return Int((spellAttackBonusText!.text)!)!
    }
    
    var _spellSaveDC: Int {
        if Int((spellSaveDCText?.text!)!) == nil {
            return 0
        }
        return Int((spellSaveDCText!.text)!)!
    }
    
    var _currentSlots: [Int] {
        var temp : [Int] = []
        for i in 0..<10 {
            if Int((currentSlots[i].text!)) == nil {
                temp.append(0)
            }
            else {
                temp.append(Int((currentSlots[i].text)!)!)
            }
        }
        return temp
    }
    
    var _totalSlots: [Int] {
        var temp : [Int] = []
        for i in 0..<10 {
            if Int((totalSlots[i].text!)) == nil {
                temp.append(0)
            }
            else {
                temp.append(Int((totalSlots[i].text)!)!)
            }
        }
        return temp
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for i in 0..<10 {
            let temp = UILabel()
            temp.font = UIFont(name: "Helvetica", size: fontSize)

            
            if i == 0 {
                temp.text = "Cantrips:"
            }
            else {
                temp.text = String(i) + "."
            }
            
            spellLabels.append(temp)
            
            let tempButton = UIButton()
            
            tempButton.addTarget(self, action: #selector(addSpell), for: .touchUpInside)
            tempButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
            tempButton.setTitle("Add Spell", for: .normal)
            tempButton.backgroundColor = UIColor.blue
            tempButton.tag = i
            
            spellButtons.append(tempButton)
            
            let tempCollection = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
            tempCollection.tag = i
            spells.append(tempCollection)
            
            let t = UILabel()
            t.font = UIFont(name: "Helvetica", size: fontSize)
            t.text = "Spell Slots: "
            spellSlotLabels.append(t)
            
            let t2 = UITextField()
            t2.delegate = self
            t2.borderStyle = .bezel
            t2.font = UIFont(name: "Helvetica", size: fontSize)
            currentSlots.append(t2)
            
            let t3 = UILabel()
            t3.text = "/"
            t3.textAlignment = .center
            slashLabels.append(t3)

            
            let t4 = UITextField()
            t4.delegate = self
            t4.borderStyle = .bezel
            t4.font = UIFont(name: "Helvetica", size: fontSize)
            totalSlots.append(t4)

        }
        
        backgroundColor = UIColor.white
        
        spellClass = UILabel()
        spellAbility = UILabel()
        spellAttackBonus = UILabel()
        spellSaveDC = UILabel()
        
        spellClass?.text = "Spellcasting Class: "
        spellAbility?.text = "Spellcasting Ability: "
        spellAttackBonus?.text = "Spell Attack Bonus: "
        spellSaveDC?.text = "Spell Save DC: "
        
        spellClassText = UITextField()
        spellAbilityText = UITextField()
        spellAttackBonusText = UITextField()
        spellSaveDCText = UITextField()
        
        spellAttackBonusText?.delegate = self
        spellSaveDCText?.delegate = self
        
        spellClass?.font = UIFont(name: "Helvetica", size: fontSize)
        spellAbility?.font = UIFont(name: "Helvetica", size: fontSize)
        spellAttackBonus?.font = UIFont(name: "Helvetica", size: fontSize)
        spellSaveDC?.font = UIFont(name: "Helvetica", size: fontSize)
        
        spellClassText?.font = UIFont(name: "Helvetica", size: fontSize)
        spellAbilityText?.font = UIFont(name: "Helvetica", size: fontSize)
        spellAttackBonusText?.font = UIFont(name: "Helvetica", size: fontSize)
        spellSaveDCText?.font = UIFont(name: "Helvetica", size: fontSize)
        
        spellClassText?.borderStyle = .bezel
        spellAbilityText?.borderStyle = .bezel
        spellAttackBonusText?.borderStyle = .bezel
        spellSaveDCText?.borderStyle = .bezel
        
        addSubview(spellClass!)
        addSubview(spellAbility!)
        addSubview(spellAttackBonus!)
        addSubview(spellSaveDC!)
        addSubview(spellClassText!)
        addSubview(spellAbilityText!)
        addSubview(spellAttackBonusText!)
        addSubview(spellSaveDCText!)
        
        for i in 0..<10 {
            addSubview(spellLabels[i])
            addSubview(spellButtons[i])
            addSubview(spells[i])
            addSubview(spellSlotLabels[i])
            addSubview(currentSlots[i])
            addSubview(slashLabels[i])
            addSubview(totalSlots[i])
        }
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height / 4
        let w: CGFloat = r.width
        var temp : CGRect
        
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        
        (spellClass!.frame, temp) = temp.divided(atDistance: w * 0.3, from: .minXEdge)
        (spellClassText!.frame, temp) = temp.divided(atDistance: w * 0.15, from: .minXEdge)
        (_, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        (spellAbility!.frame, temp) = temp.divided(atDistance: w * 0.3, from: .minXEdge)
        (spellAbilityText!.frame, temp) = temp.divided(atDistance: w * 0.2, from: .minXEdge)
        
        (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)

        (spellAttackBonus!.frame, temp) = temp.divided(atDistance: w * 0.3, from: .minXEdge)
        (spellAttackBonusText!.frame, temp) = temp.divided(atDistance: w * 0.15, from: .minXEdge)
        (_, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        (spellSaveDC!.frame, temp) = temp.divided(atDistance: w * 0.3, from: .minXEdge)
        (spellSaveDCText!.frame, temp) = temp.divided(atDistance: w * 0.2, from: .minXEdge)
        
        for i in 0..<10 {
            (temp, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
            (spellLabels[i].frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
            (spellButtons[i].frame, temp) = temp.divided(atDistance: w * 0.15, from: .minXEdge)
            (_, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)

            
            (spellSlotLabels[i].frame, temp) = temp.divided(atDistance: w * 0.2, from: .minXEdge)
            (currentSlots[i].frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
            (slashLabels[i].frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
            (totalSlots[i].frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
            (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
            (spells[i].frame, r) = r.divided(atDistance: h * 0.25, from: .minYEdge)
            (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func addSpell(sender: UIButton) {
        delegate.addSpell(level: sender.tag)
    }
    
    func update(spellcastingClass: String, spellcastingAbility: String, spellAttackBonus : Int, spellSaveDC : Int, spellSlotsCur: [Int], spellSlotsTotal: [Int]) {
        
        spellClassText?.text =  spellcastingClass
        spellAbilityText?.text = spellcastingAbility
        spellAttackBonusText?.text = String(spellAttackBonus)
        spellSaveDCText?.text = String(spellSaveDC)
        
        for i in 0..<currentSlots.count {
            currentSlots[i].text = String(spellSlotsCur[i])
            totalSlots[i].text = String(spellSlotsTotal[i])
        }
        
        setNeedsDisplay()
    }
}
