//
//  PlayerBackstoryView.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class PlayerBackstoryView : UIScrollView {
    private var backstory : UILabel?
    private var backstoryText : UITextView?
    
    private var alliesAndOrganizations : UILabel?
    private var alliesAndOrganizationsText : UITextView?
    
    private var featsAndTraits : UILabel?
    private var featsAndTraitsText : UITextView?
    
    private var treasure : UILabel?
    private var treasureText : UITextView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        backstory = UILabel()
        backstoryText = UITextView()
        
        alliesAndOrganizations = UILabel()
        alliesAndOrganizationsText = UITextView()
        
        featsAndTraits = UILabel()
        featsAndTraitsText = UITextView()
        
        treasure = UILabel()
        treasureText = UITextView()

        backstory?.text = "Backstory:"
        backstory?.font = UIFont(name: "Helvetica", size: 15)
        
        alliesAndOrganizations?.text = "Allies & Organizations:"
        alliesAndOrganizationsText?.font = UIFont(name: "Helvetica", size: 15)
        
        featsAndTraits?.text = "Feats & Traits:"
        featsAndTraitsText?.font = UIFont(name: "Helvetica", size: 15)
        
        treasure?.text = "Treasure:"
        treasureText?.font = UIFont(name: "Helvetica", size: 15)
        
        backstoryText?.backgroundColor = UIColor.lightGray
        alliesAndOrganizationsText?.backgroundColor = UIColor.lightGray
        featsAndTraitsText?.backgroundColor = UIColor.lightGray
        treasureText?.backgroundColor = UIColor.lightGray
        
        addSubview(backstory!)
        addSubview(backstoryText!)
        addSubview(alliesAndOrganizations!)
        addSubview(alliesAndOrganizationsText!)
        addSubview(featsAndTraits!)
        addSubview(featsAndTraitsText!)
        addSubview(treasure!)
        addSubview(treasureText!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        let h: CGFloat = r.height
        
        (backstory!.frame, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (backstoryText!.frame, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)
        (alliesAndOrganizations!.frame, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (alliesAndOrganizationsText!.frame, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)
        (featsAndTraits!.frame, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (featsAndTraitsText!.frame, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)
        (treasure!.frame, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (treasureText!.frame, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)

    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
}
