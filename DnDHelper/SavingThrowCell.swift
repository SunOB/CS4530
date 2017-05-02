//
//  SavingThrowCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/30/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol SavingThrowCellDelegate {
    func savingThrowChanged(num: Int, value: Int)
    func proficiencyChanged(num: Int)
}

class SavingThrowCell : UICollectionViewCell, UITextFieldDelegate {
    var delegate : SavingThrowCellDelegate!
    private var savingThrowLabel : UILabel?
    private var savingThrowProficiency : UIButton?
    
    private var savingThrowValue : UITextField?
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        savingThrowLabel = UILabel()
        savingThrowProficiency = UIButton()
        savingThrowProficiency?.addTarget(self, action: #selector(proficiencyPressed),for: .touchUpInside)
        savingThrowProficiency?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        
        savingThrowValue = UITextField()
        
        savingThrowValue?.delegate = self
        savingThrowValue?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        savingThrowValue?.borderStyle = UITextBorderStyle.bezel
        savingThrowValue?.backgroundColor = UIColor.lightText
        
        savingThrowLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        savingThrowValue?.font = UIFont(name: "Helvetica", size: 7.5)

        
        contentView.addSubview(savingThrowLabel!)
        contentView.addSubview(savingThrowValue!)
        contentView.addSubview(savingThrowProficiency!)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged (sender: UITextField?) {
        var temp = Int(savingThrowValue!.text!)
        if temp == nil {
            temp = 0
        }
        delegate.savingThrowChanged(num: num, value: temp!)
    }
    
    func updateCell(stat: String, value: Int, proficient: Bool) {
        savingThrowLabel?.text = stat + ": "
        savingThrowValue?.text = String(value)
        
        if proficient {
            savingThrowProficiency?.setBackgroundImage(#imageLiteral(resourceName: "FilledCircle"), for: .normal)
        }
        else {
            savingThrowProficiency?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        }
    }
    
    func proficiencyPressed(sender: UIButton) {
        delegate.proficiencyChanged(num: num)
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        var temp : CGRect
        (_, r) = r.divided(atDistance: h * 0.05, from: .maxYEdge)
        (_, r) = r.divided(atDistance: h * 0.1, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.05, from: .minXEdge)
        (temp, r) = r.divided(atDistance: h * 0.5, from: .minYEdge)
        savingThrowProficiency!.frame = CGRect(x: 2, y: h * 0.5 - 5, width: 10, height: 10)
        (_, temp) = temp.divided(atDistance: 12, from: .minXEdge)
        (savingThrowLabel!.frame, temp) = temp.divided(atDistance: w - 20, from: .minXEdge)
        (_, r) = r.divided(atDistance: 12, from: .minXEdge)
        (savingThrowValue!.frame, r) = r.divided(atDistance: w - 20, from: .minXEdge)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789-").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
}
