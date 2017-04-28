//
//  BestiaryEntryCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/27/17.
//  Copyright © 2017 u0771753. All rights reserved.
//


//Fix exception when alert is fired

import UIKit

protocol BestiaryEntryDelegate {
    func valueChanged(name: String, ac: Int, hp: Int, pg: Int, _num: Int)
    func invalidInput()
}

class BestiaryEntryCell : UICollectionViewCell {
    var delegate : BestiaryEntryDelegate!
    private var acLabel : UILabel?
    private var hpLabel : UILabel?
    private var pgLabel : UILabel?
    
    private var nameText : UITextField?
    private var acText : UITextField?
    private var hpText : UITextField?
    private var pgText : UITextField?
    
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        acLabel = UILabel()
        hpLabel = UILabel()
        pgLabel = UILabel()
        
        nameText = UITextField()
        acText = UITextField()
        hpText = UITextField()
        pgText = UITextField()
        
        acLabel?.text = "AC: "
        hpLabel?.text = "HP: "
        pgLabel?.text = "Page: "
        
        nameText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        acText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        hpText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        pgText?.addTarget(self, action: #selector(textChanged), for: .editingDidEnd)
        
        acLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        hpLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        pgLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        
        nameText?.borderStyle = UITextBorderStyle.bezel
        acText?.borderStyle = UITextBorderStyle.bezel
        hpText?.borderStyle = UITextBorderStyle.bezel
        pgText?.borderStyle = UITextBorderStyle.bezel
        
        acText?.font = UIFont(name: "Helvetica", size: 7.5)
        hpText?.font = UIFont(name: "Helvetica", size: 7.5)
        pgText?.font = UIFont(name: "Helvetica", size: 7.5)
        
        nameText?.backgroundColor = UIColor.white
        acText?.backgroundColor = UIColor.white
        hpText?.backgroundColor = UIColor.white
        pgText?.backgroundColor = UIColor.white

        contentView.addSubview(acLabel!)
        contentView.addSubview(hpLabel!)
        contentView.addSubview(pgLabel!)
        contentView.addSubview(nameText!)
        contentView.addSubview(acText!)
        contentView.addSubview(hpText!)
        contentView.addSubview(pgText!)
        
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged (sender: UITextField?) {
        
        var intAC, intHP, intPG : Int?
        
        if ((acText?.text)! == "") {
            intAC = 0
        }
        else {
            intAC = Int((acText?.text)!)
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
        
        if (intAC == nil || intHP == nil || intPG == nil) {
            delegate.invalidInput()
        }
        else {
            delegate.valueChanged(name: (nameText?.text)!, ac: intAC!, hp: intHP!, pg: intPG!, _num: num!)
        }
    }
    
    func updateCell(name: String, ac: Int, hp: Int, pg: Int) {
        nameText?.text = name
        acText?.text = String(ac)
        hpText?.text = String(hp)
        pgText?.text = String(pg)
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        (nameText!.frame, r) = r.divided(atDistance: h * 0.45, from: .minYEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.05, from: .minXEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.05, from: .maxXEdge)

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
    
}
