//
//  SpellCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol SpellCellDelegate {
    func update(level : Int, _num : Int, prepared: Bool)
    func update(level : Int, _num : Int, name : String)
    func delete(level : Int, _num: Int)
}

class SpellCell : UICollectionViewCell {
    private var name : UITextField?
    private var prepared : Bool
    private var preparedButton : UIButton?
    
    private var deleteButton : UIButton?
    
    var num : Int!
    var level : Int!
    
    var delegate : SpellCellDelegate!
    
    override init(frame: CGRect) {
        prepared = false
        
        super.init(frame: frame)
        name = UITextField()
        
        name?.borderStyle = .bezel
        name?.font = UIFont(name: "Helvetica", size: 7.5)
        
        preparedButton = UIButton()
        preparedButton?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCheckbox"), for: .normal)

        deleteButton = UIButton()
        
        preparedButton?.addTarget(self, action: #selector(clickedPrepared), for: .touchUpInside)
        name?.addTarget(self, action: #selector(changedName), for: .editingDidEnd)
        
        deleteButton?.addTarget(self, action: #selector(deleteSpell), for: .touchUpInside)
        deleteButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        deleteButton?.setTitle("Delete", for: .normal)
        deleteButton?.backgroundColor = UIColor.blue
        
        backgroundColor = UIColor.white
        
        addSubview(name!)
        addSubview(preparedButton!)
        addSubview(deleteButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        let w: CGFloat = r.width
        
        (preparedButton!.frame, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (name!.frame, r) = r.divided(atDistance: w * 0.7, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (deleteButton!.frame, r) = r.divided(atDistance: w * 0.2, from: .minXEdge)
    }
    
    func updateCell(name: String, isPrepared: Bool) {
        self.name?.text = name
        if (!isPrepared) {
            preparedButton?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCheckbox"), for: .normal)
        }
        else {
            preparedButton?.setBackgroundImage(#imageLiteral(resourceName: "CheckedCheckbox"), for: .normal)
        }
    }
    
    func clickedPrepared(sender: UIButton?) {
        if (prepared) {
            prepared = false
            preparedButton?.setBackgroundImage(#imageLiteral(resourceName: "EmptyCheckbox"), for: .normal)
        }
        else {
            prepared = true
            preparedButton?.setBackgroundImage(#imageLiteral(resourceName: "CheckedCheckbox"), for: .normal)
        }
        delegate.update(level: level, _num: num, prepared: prepared)

    }
    
    func changedName() {
        delegate.update(level: level, _num: num, name: (name?.text!)!)
    }
    
    func deleteSpell() {
        endEditing(true)
        delegate.delete(level: level, _num: num)
    }
}
