//
//  ModuleCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/29/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol ModuleCellDelegate {
    func editCell(_num: Int)
    func deleteCell(_num: Int)
    func toggleCompleteCell(_num: Int)
    func updateName(_num: Int, name: String)
    func updateShortDesc(_num: Int, shortDesc : String)
}

class ModuleCell : UICollectionViewCell, UITextViewDelegate {
    var delegate : ModuleCellDelegate!
    private var shortDescLabel : UILabel?
    private var nameText : UITextField?
    private var shortDescText : UITextView?
    
    private var editButton : UIButton?
    private var deleteButton : UIButton?
    private var completedButton : UIButton?
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shortDescLabel = UILabel()
        nameText = UITextField()
        
        shortDescText = UITextView()
        
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
        
        completedButton = UIButton()
        completedButton?.addTarget(self, action: #selector(completePressed),for: .touchUpInside)
        
        shortDescLabel?.text = "Short Description: "
        nameText?.text = ""
        
        shortDescLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        
        nameText?.font = UIFont(name: "Helvetica", size: 7.5)
        nameText?.backgroundColor = UIColor.lightText
        
        shortDescText?.backgroundColor = UIColor.lightText
        shortDescText?.font = UIFont(name: "Helvetica", size: 7.5)
        
        nameText?.addTarget(self, action: #selector(nameChanged), for: .editingDidEnd)
        shortDescText?.delegate = self
        
        editButton?.backgroundColor = UIColor.darkGray
        deleteButton?.backgroundColor = UIColor.green
        completedButton?.backgroundColor = UIColor.purple
        
        contentView.addSubview(shortDescLabel!)
        contentView.addSubview(nameText!)
        contentView.addSubview(shortDescText!)
        contentView.addSubview(editButton!)
        contentView.addSubview(deleteButton!)
        contentView.addSubview(completedButton!)
        
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(name : String) {
        nameText?.text = name
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (nameText!.frame, r) = r.divided(atDistance: h * 0.3, from: .minYEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        
        //MaxXEdge
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (completedButton!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.1, from: .maxXEdge)
        
        (_, completedButton!.frame) = completedButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, completedButton!.frame) = completedButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, completedButton!.frame) = completedButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, completedButton!.frame) = completedButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        (deleteButton!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        (editButton!.frame, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.1, from: .maxXEdge)
        (_, nameText!.frame) = nameText!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .maxXEdge)
        (shortDescLabel!.frame, r) = r.divided(atDistance: h * 0.1, from: .minYEdge)
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (shortDescText!.frame, r) = r.divided(atDistance: h * 0.55, from: .minYEdge)
    }
    
    func editPressed(sender: UIButton) {
        endEditing(false)
        delegate.editCell(_num: num)
    }
    
    func deletePressed(sender: UIButton) {
        delegate.deleteCell(_num: num)
    }
    
    func nameChanged () {
        delegate.updateName(_num: num, name: (nameText?.text)!)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate.updateShortDesc(_num: num, shortDesc: (shortDescText?.text)!)
    }
    
    func completePressed() {
        //Add image swapping here
        
        setNeedsDisplay()
        delegate.toggleCompleteCell(_num: num)
    }
}



