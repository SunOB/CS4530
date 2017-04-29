//
//  CombatantCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/27/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol CombatantDelegate {
    func valueChanged(name: String, initiative: Int, ac: Int, hp: Int, pg: Int, _num: Int)
    func invalidInput()
    func deletePressed(_num: Int)
}

class CombatantCell : UICollectionViewCell {
    var delegate : CombatantDelegate!
    private var acLabel : UILabel?
    private var hpLabel : UILabel?
    private var pgLabel : UILabel?
    private var initiativeLabel : UILabel?
    
    private var nameText : UITextField?
    private var acText : UITextField?
    private var hpText : UITextField?
    private var pgText : UITextField?
    private var initiativeText : UITextField?
    
    private var deleteButton : UIButton?
    
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        acLabel = UILabel()
        hpLabel = UILabel()
        pgLabel = UILabel()
        initiativeLabel = UILabel()
        
        nameText = UITextField()
        acText = UITextField()
        hpText = UITextField()
        pgText = UITextField()
        initiativeText = UITextField()
        
        deleteButton = UIButton()
        deleteButton?.addTarget(self, action: #selector(deletePressed),for: .touchUpInside)
        
        deleteButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        deleteButton?.setTitle("Delete", for: .normal)
        deleteButton?.contentHorizontalAlignment = .center
        
        acLabel?.text = "AC: "
        hpLabel?.text = "HP: "
        pgLabel?.text = "Page: "
        initiativeLabel?.text = "Initiative: "
        
        nameText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        acText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        hpText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        pgText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        initiativeText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)

        acLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        hpLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        pgLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        initiativeLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        
        nameText?.borderStyle = UITextBorderStyle.bezel
        acText?.borderStyle = UITextBorderStyle.bezel
        hpText?.borderStyle = UITextBorderStyle.bezel
        pgText?.borderStyle = UITextBorderStyle.bezel
        initiativeText?.borderStyle = UITextBorderStyle.bezel

        nameText?.font = UIFont(name: "Helvetica", size: 7.5)
        acText?.font = UIFont(name: "Helvetica", size: 7.5)
        hpText?.font = UIFont(name: "Helvetica", size: 7.5)
        pgText?.font = UIFont(name: "Helvetica", size: 7.5)
        initiativeText?.font = UIFont(name: "Helvetica", size: 7.5)


        nameText?.backgroundColor = UIColor.lightText
        acText?.backgroundColor = UIColor.lightText
        hpText?.backgroundColor = UIColor.lightText
        pgText?.backgroundColor = UIColor.lightText
        initiativeText?.backgroundColor = UIColor.lightText
        
        deleteButton?.backgroundColor = UIColor.darkGray
        
        contentView.addSubview(acLabel!)
        contentView.addSubview(hpLabel!)
        contentView.addSubview(pgLabel!)
        contentView.addSubview(initiativeLabel!)
        contentView.addSubview(nameText!)
        contentView.addSubview(acText!)
        contentView.addSubview(hpText!)
        contentView.addSubview(pgText!)
        contentView.addSubview(initiativeText!)
        contentView.addSubview(deleteButton!)
        
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged (sender: UITextField?) {
        
        var intAC, intHP, intPG, intInitiative : Int?
        
        if ((acText?.text)! == "") {
            intAC = 0
        }
        else {
            intAC = Int((acText?.text)!)
        }
        
        if ((initiativeText?.text)! == "") {
            intInitiative = 0
        }
        else {
            intInitiative = Int((initiativeText?.text)!)
        }
        
        if ((hpText?.text)! == "") {
            intHP = 0
        }
        else {
            intHP = Int((hpText?.text)!)
            
        }
        
        if ((pgText?.text)! == "") {
            intPG = 0
        }
        else {
            intPG = Int((pgText?.text)!)
            
        }
        
        if (intInitiative == nil || intAC == nil || intHP == nil || intPG == nil) {
            delegate.invalidInput()
        }
        else {
            delegate.valueChanged(name: (nameText?.text)!, initiative: intInitiative! ,ac: intAC!, hp: intHP!, pg: intPG!, _num: num!)
        }
    }
    
    func updateCell(name: String, initiative: Int, ac: Int, hp: Int, pg: Int) {
        nameText?.text = name
        acText?.text = String(ac)
        hpText?.text = String(hp)
        pgText?.text = String(pg)
        initiativeText?.text = String(initiative)
        
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (nameText!.frame, r) = r.divided(atDistance: h * 0.44, from: .minYEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.01, from: .minXEdge)
        
        //MaxXEdge
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.02, from: .maxXEdge)
        (deleteButton!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.02, from: .maxXEdge)
        (initiativeText!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.1, from: .maxXEdge)
        (initiativeLabel!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.1, from: .maxXEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.02, from: .maxXEdge)
        
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (acLabel!.frame, r) = r.divided(atDistance: w * 0.05, from: .minXEdge)
        (acText!.frame, r) = r.divided(atDistance: w * 0.125, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.075, from: .minXEdge)
        (hpLabel!.frame, r) = r.divided(atDistance: w * 0.05, from: .minXEdge)
        (hpText!.frame, r) = r.divided(atDistance: w * 0.15, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.075, from: .minXEdge)
        (pgLabel!.frame, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (pgText!.frame, r) = r.divided(atDistance: w * 0.15, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
    }
    
    
    func deletePressed(sender: UIButton) {
        endEditing(false)
        delegate.deletePressed(_num: num)
    }
}
