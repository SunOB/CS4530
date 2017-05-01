//
//  StatCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/30/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol StatCellDelegate {
    func statChanged(_num: Int, value: Int)
}

class StatCell : UICollectionViewCell, UITextFieldDelegate {
    var delegate : StatCellDelegate!
    private var statLabel : UILabel?
    private var modifierLabel : UILabel?

    private var statValue : UITextField?
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        statLabel = UILabel()
        modifierLabel = UILabel()
        
        statValue = UITextField()
        
        statValue?.delegate = self
        statValue?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        statValue?.borderStyle = UITextBorderStyle.bezel
        statValue?.backgroundColor = UIColor.lightText
        
        statLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        modifierLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        statValue?.font = UIFont(name: "Helvetica", size: 7.5)

        
        contentView.addSubview(statValue!)
        contentView.addSubview(statLabel!)
        contentView.addSubview(modifierLabel!)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged (sender: UITextField?) {
        modifierLabel?.text = String((Int(statValue!.text!)! - 10) / 2)
        delegate.statChanged(_num: num, value: Int(statValue!.text!)!)
    }
    
    func updateCell(stat: String, value: Int) {
        statLabel?.text = stat + ": "
        statValue?.text = String(value)
        modifierLabel?.text = String((Int(statValue!.text!)! - 10) / 2)
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        var temp : CGRect
        
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (temp, r) = r.divided(atDistance: h * 0.6, from: .minYEdge)
        (_, temp) = temp.divided(atDistance: w * 0.05, from: .minXEdge)
        
        (statLabel!.frame, temp) = temp.divided(atDistance: w * 0.6, from: .minXEdge)
        (statValue!.frame, temp) = temp.divided(atDistance: w * 0.35, from: .minXEdge)
        
        (_, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.4, from: .minXEdge)
        (modifierLabel!.frame, r) = r.divided(atDistance: w * 0.2, from: .minXEdge)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }

}
