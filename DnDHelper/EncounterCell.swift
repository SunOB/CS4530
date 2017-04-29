//
//  EncounterCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/28/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol EncounterCellDelegate {
    func encDeleteCell(_num: Int)
    func encEditCell(_num: Int)
}

class EncounterCell : UICollectionViewCell {
    var delegate : EncounterCellDelegate!
    private var combatantsLabel : UILabel?
    private var nameLabel : UILabel?
    private var combatantsBodyLabel : UILabel?
    
    private var editButton : UIButton?
    private var deleteButton : UIButton?
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        combatantsLabel = UILabel()
        nameLabel = UILabel()
        
        combatantsBodyLabel = UILabel()
        
        editButton = UIButton()
        editButton?.addTarget(self, action: #selector(editPressed),for: .touchUpInside)
        
        editButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        editButton?.setTitle("Edit", for: .normal)
        editButton?.contentHorizontalAlignment = .center
        
        deleteButton = UIButton()
        deleteButton?.addTarget(self, action: #selector(deletePressed),for: .touchUpInside)
        
        deleteButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        deleteButton?.setTitle("Delete", for: .normal)
        deleteButton?.contentHorizontalAlignment = .center
        
        combatantsLabel?.text = "Combatants: "
        nameLabel?.text = "Name"
        
        combatantsLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        nameLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        
        combatantsBodyLabel?.backgroundColor = UIColor.lightText
        
        combatantsBodyLabel?.adjustsFontSizeToFitWidth = true
        combatantsBodyLabel?.numberOfLines = 0
        
        editButton?.backgroundColor = UIColor.darkGray
        deleteButton?.backgroundColor = UIColor.green
        
        contentView.addSubview(combatantsLabel!)
        contentView.addSubview(nameLabel!)
        contentView.addSubview(combatantsBodyLabel!)
        contentView.addSubview(editButton!)
        contentView.addSubview(deleteButton!)
        
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(name : String, combatantsList : String) {
        combatantsBodyLabel?.text = combatantsList
        nameLabel?.text = name
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (nameLabel!.frame, r) = r.divided(atDistance: h * 0.3, from: .minYEdge)
        (_, nameLabel!.frame) = nameLabel!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        
        //MaxXEdge
        (_, nameLabel!.frame) = nameLabel!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (deleteButton!.frame, nameLabel!.frame) = nameLabel!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        
        (_, nameLabel!.frame) = nameLabel!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (editButton!.frame, nameLabel!.frame) = nameLabel!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        (_, nameLabel!.frame) = nameLabel!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .maxXEdge)
        (combatantsLabel!.frame, r) = r.divided(atDistance: h * 0.1, from: .minYEdge)
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (combatantsBodyLabel!.frame, r) = r.divided(atDistance: h * 0.55, from: .minYEdge)
    }
    
    func editPressed(sender: UIButton) {
        delegate.encEditCell(_num: num)
    }
    
    func deletePressed(sender: UIButton) {
        delegate.encDeleteCell(_num: num)
    }
}


