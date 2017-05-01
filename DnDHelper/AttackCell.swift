//
//  AttackCell.swift
//  DnDHelper
//
//  Created by u0771753 on 5/1/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol AttackCellDelegate {
    func attackChanged(_num: Int, name: String, attackBonus : Int, damageDie : Int, damageDieCount : Int, damageBonus : Int, type : String, bonusEffects : String)
}

class AttackCell : UICollectionViewCell, UITextFieldDelegate {
    var delegate : AttackCellDelegate!
    private var dLabel : UILabel?
    private var plusLabel : UILabel?
    
    private var nameText : UITextField?
    private var attackBonusText : UITextField?
    private var damageDieText : UITextField?
    private var damageDieCountText : UITextField?
    private var damageBonusText : UITextField?
    private var typeText : UITextField?
    
    private var bonusEffectsText : UITextView?
    
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dLabel = UILabel()
        plusLabel = UILabel()
        
        //dLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        //plusLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        
        dLabel?.text = "d"
        plusLabel?.text = "+"
        
        nameText = UITextField()
        attackBonusText = UITextField()
        damageDieText = UITextField()
        damageDieCountText = UITextField()
        damageBonusText = UITextField()
        typeText = UITextField()
        
        nameText?.font = UIFont(name: "Helvetica", size: 7.5)
        attackBonusText?.font = UIFont(name: "Helvetica", size: 7.5)
        damageDieText?.font = UIFont(name: "Helvetica", size: 7.5)
        damageDieCountText?.font = UIFont(name: "Helvetica", size: 7.5)
        damageBonusText?.font = UIFont(name: "Helvetica", size: 7.5)
        typeText?.font = UIFont(name: "Helvetica", size: 7.5)
        
        nameText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        nameText?.borderStyle = UITextBorderStyle.bezel
        nameText?.backgroundColor = UIColor.lightText
        
        attackBonusText?.delegate = self
        attackBonusText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        attackBonusText?.borderStyle = UITextBorderStyle.bezel
        attackBonusText?.backgroundColor = UIColor.lightText
        
        damageDieText?.delegate = self
        damageDieText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        damageDieText?.borderStyle = UITextBorderStyle.bezel
        damageDieText?.backgroundColor = UIColor.lightText
        
        damageDieCountText?.delegate = self
        damageDieCountText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        damageDieCountText?.borderStyle = UITextBorderStyle.bezel
        damageDieCountText?.backgroundColor = UIColor.lightText
        
        damageBonusText?.delegate = self
        damageBonusText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        damageBonusText?.borderStyle = UITextBorderStyle.bezel
        damageBonusText?.backgroundColor = UIColor.lightText
        
        typeText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        typeText?.borderStyle = UITextBorderStyle.bezel
        typeText?.backgroundColor = UIColor.lightText
        
        bonusEffectsText = UITextView()
        bonusEffectsText?.font = UIFont(name: "Helvetica", size: 7.5)
        bonusEffectsText?.layer.borderColor = UIColor.black.cgColor
        bonusEffectsText?.layer.borderWidth = 1
        
        contentView.addSubview(dLabel!)
        contentView.addSubview(plusLabel!)
        contentView.addSubview(nameText!)
        contentView.addSubview(attackBonusText!)
        contentView.addSubview(damageDieText!)
        contentView.addSubview(damageDieCountText!)
        contentView.addSubview(damageBonusText!)
        contentView.addSubview(typeText!)
        contentView.addSubview(bonusEffectsText!)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged (sender: UITextField?) {
        var n, type, bonus : String
        var aB, dD, dDC, dB : Int

        if nameText?.text == nil {
            n = ""
        }
        else {
            n = (nameText?.text)!
        }
        
        if typeText?.text == nil {
            type = ""
        }
        else {
            type = (typeText?.text)!
        }
        
        if bonusEffectsText?.text == nil {
            bonus = "Bonus Effects"
        }
        else {
            bonus = (bonusEffectsText?.text)!
        }
        
        if Int((attackBonusText?.text)!) == nil {
            aB = 0
        }
        else {
            aB = Int((attackBonusText?.text)!)!
        }
        
        if Int((damageDieText?.text)!) == nil {
            dD = 0
        }
        else {
            dD = Int((damageDieText?.text)!)!
        }
        
        if Int((damageDieCountText?.text)!) == nil {
            dDC = 0
        }
        else {
            dDC = Int((damageDieCountText?.text)!)!
        }
        
        if Int((damageBonusText?.text)!) == nil {
            dB = 0
        }
        else {
            dB = Int((damageBonusText?.text)!)!
        }
        
        
        
        delegate.attackChanged(_num: num, name: n, attackBonus : aB, damageDie : dD, damageDieCount : dDC, damageBonus : dB, type : type, bonusEffects : bonus)
    }
    
    func updateCell(name: String, attackBonus : Int, damageDie : Int, damageDieCount : Int, damageBonus : Int, type : String, bonusEffects : String) {
        nameText?.text = name
        attackBonusText?.text = String(attackBonus)
        damageDieText?.text = String(damageDie)
        damageDieCountText?.text = String(damageDieCount)
        damageBonusText?.text = String(damageBonus)
        typeText?.text = type
        bonusEffectsText?.text = bonusEffects
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        var temp : CGRect
        
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.5, from: .minYEdge)
        
        (nameText!.frame, temp) = temp.divided(atDistance: w * 0.25, from: .minXEdge)
        (_, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        (attackBonusText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (_, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        (damageDieCountText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (dLabel!.frame, temp) = temp.divided(atDistance: w * 0.035, from: .minXEdge)
        (damageDieText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (plusLabel!.frame, temp) = temp.divided(atDistance: w * 0.035, from: .minXEdge)
        (damageBonusText!.frame, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (typeText!.frame, temp) = temp.divided(atDistance: w * 0.2, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (bonusEffectsText!.frame, r) = r.divided(atDistance: w, from: .minXEdge)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
}
