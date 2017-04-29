//
//  DescriptionView.swift
//  DnDHelper
//
//  Created by u0771753 on 4/29/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class DescriptionView : UIView {
    private var descriptionText : UITextView?
    
    public var text : String {
        return (descriptionText?.text)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white

        descriptionText = UITextView()
        descriptionText?.font = UIFont(name: "Helvetica", size: 10)
        
        descriptionText?.backgroundColor = UIColor.lightGray
    
        addSubview(descriptionText!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionText?.frame = bounds
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    public func update(text: String) {
        descriptionText?.text = text
        super.setNeedsDisplay()
    }
    
}

