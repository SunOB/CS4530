//
//  DescriptionCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/28/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol DescriptionCellDelegate {
    func descDeleteCell(_num: Int)
    func descEditCell(_num: Int)
}

class DescriptionCell : UICollectionViewCell {
    var delegate : DescriptionCellDelegate!
    private var titleLabel : UILabel?
    private var descriptionTextView : UITextView?
    
    private var editButton : UIButton?
    private var deleteButton : UIButton?
    var num : Int!
    
    var height : CGFloat {
        return titleLabel!.frame.height + descriptionTextView!.frame.height + 20.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        descriptionTextView = UITextView()
        
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
        
        titleLabel?.text = "Description: "
        
        titleLabel?.font = UIFont(name: "Helvetica", size: 7.5)
        descriptionTextView?.font = UIFont(name: "Helvetica", size: 7.5)
        descriptionTextView?.isEditable = false
        
        editButton?.backgroundColor = UIColor.darkGray
        deleteButton?.backgroundColor = UIColor.green
        
        contentView.addSubview(descriptionTextView!)
        contentView.addSubview(titleLabel!)
        contentView.addSubview(editButton!)
        contentView.addSubview(deleteButton!)
        
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (titleLabel!.frame, r) = r.divided(atDistance: h * 0.3, from: .minYEdge)
        (_, titleLabel!.frame) = titleLabel!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        
        //MaxXEdge
        (_, titleLabel!.frame) = titleLabel!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (deleteButton!.frame, titleLabel!.frame) = titleLabel!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        
        (_, titleLabel!.frame) = titleLabel!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (editButton!.frame, titleLabel!.frame) = titleLabel!.frame.divided(atDistance: w * 0.2, from: .maxXEdge)
        (_, titleLabel!.frame) = titleLabel!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        
        (_, r) = r.divided(atDistance: h * 0.01, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.1, from: .maxXEdge)
        (descriptionTextView!.frame, r) = r.divided(atDistance: h * 0.55, from: .minYEdge)
    }
    
    func editPressed(sender: UIButton) {
        delegate.descEditCell(_num: num)
    }
    
    func deletePressed(sender: UIButton) {
        delegate.descDeleteCell(_num: num)
    }
    
    func update(title: String, desc : String) {
        titleLabel?.text = title
        descriptionTextView?.text = desc
        setNeedsDisplay()
    }
}


