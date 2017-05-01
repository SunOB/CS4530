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
    func entrySelected(_num: Int)
}

class BestiaryEntryCell : UICollectionViewCell, UITextFieldDelegate {
    var delegate : BestiaryEntryDelegate!
    private var acLabel : UILabel?
    private var hpLabel : UILabel?
    private var pgLabel : UILabel?
    
    private var nameText : UITextField?
    private var acText : UITextField?
    private var hpText : UITextField?
    private var pgText : UITextField?
    
    private var selectButton : UIButton?
    
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
        
        acText?.delegate = self
        hpText?.delegate = self
        pgText?.delegate = self
        
        selectButton = UIButton()
        selectButton?.addTarget(self, action: #selector(selectPressed),for: .touchUpInside)
        
        selectButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        selectButton?.setTitle("Select", for: .normal)
        selectButton?.contentHorizontalAlignment = .center
        
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
        
        nameText?.backgroundColor = UIColor.lightText
        acText?.backgroundColor = UIColor.lightText
        hpText?.backgroundColor = UIColor.lightText
        pgText?.backgroundColor = UIColor.lightText
        
        selectButton?.backgroundColor = UIColor.darkGray

        contentView.addSubview(acLabel!)
        contentView.addSubview(hpLabel!)
        contentView.addSubview(pgLabel!)
        contentView.addSubview(nameText!)
        contentView.addSubview(acText!)
        contentView.addSubview(hpText!)
        contentView.addSubview(pgText!)
        contentView.addSubview(selectButton!)
        
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
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (nameText!.frame, r) = r.divided(atDistance: h * 0.44, from: .minYEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.05, from: .minXEdge)
        
        //MaxXEdge
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (selectButton!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.05, from: .maxXEdge)

        (_, selectButton!.frame) = selectButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, selectButton!.frame) = selectButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, selectButton!.frame) = selectButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, selectButton!.frame) = selectButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)


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
    
    
    func selectPressed(sender: UIButton) {
        endEditing(false)
        delegate.entrySelected(_num: num)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
