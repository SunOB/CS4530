//
//  SkillCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/30/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol SkillCellDelegate {
    func skillChanged(num: Int, value: Int)
    func skillProficiencyChanged(num: Int)
}

class SkillCell : UICollectionViewCell, UITextFieldDelegate {
    var delegate : SkillCellDelegate!
    private var skillLabel : UILabel?
    private var skillProficiency : UIButton?
    
    private var skillValue : UITextField?
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        skillLabel = UILabel()
        skillProficiency = UIButton()
        skillProficiency?.addTarget(self, action: #selector(proficiencyPressed),for: .touchUpInside)
        skillProficiency?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        
        skillValue = UITextField()
        
        skillValue?.delegate = self
        skillValue?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        skillValue?.borderStyle = UITextBorderStyle.bezel
        skillValue?.backgroundColor = UIColor.lightText
        
        skillLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        skillValue?.font = UIFont(name: "Helvetica", size: 7.5)
        
        
        contentView.addSubview(skillValue!)
        contentView.addSubview(skillProficiency!)
        contentView.addSubview(skillLabel!)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged (sender: UITextField?) {
        var temp = Int(skillValue!.text!)
        if temp == nil {
            temp = 0
        }
        delegate.skillChanged(num: num, value: temp!)
    }
    
    func updateCell(stat: String, value: Int, proficient: Bool) {
        skillLabel?.text = stat + ": "
        skillValue?.text = String(value)
        
        if proficient {
            skillProficiency?.setBackgroundImage(#imageLiteral(resourceName: "FilledCircle"), for: .normal)
        }
        else {
            skillProficiency?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        }
    }
    
    func proficiencyPressed(sender: UIButton) {
        delegate.skillProficiencyChanged(num: num)
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        var temp : CGRect
        
        (_, r) = r.divided(atDistance: h * 0.1, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.05, from: .minXEdge)
        (temp, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (_, temp) = temp.divided(atDistance: h * 0.3, from: .minYEdge)
        skillProficiency!.frame = CGRect(x: temp.minX, y: temp.minY, width: 10, height: 10)
        
        (_, r) = r.divided(atDistance: w * 0.05, from: .minXEdge)
        (skillLabel!.frame, r) = r.divided(atDistance: w * 0.5, from: .minXEdge)
        (skillValue!.frame, r) = r.divided(atDistance: w * 0.2, from: .minXEdge)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789-").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
}
