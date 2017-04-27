//
//  SpellCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class SpellCell : UITableViewCell {
    private var name : UITextField?
    private var prepared : Bool
    private var preparedImage : UIImageView?
    private var preparedButton : UIButton?
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        prepared = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        name = UITextField()
        preparedImage = UIImageView(image: #imageLiteral(resourceName: "EmptyCheckbox"))
        preparedButton = UIButton()
        
        preparedButton?.addTarget(self, action: #selector(clickedPrepared), for: .touchUpInside)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        let w: CGFloat = r.width
        
        (preparedImage!.frame, r) = r.divided(atDistance: w * 0.1, from: .minXEdge)
        (name!.frame, r) = r.divided(atDistance: w * 0.9, from: .minXEdge)
        
        preparedButton!.frame = (preparedImage?.frame)!
    }
    
    func clickedPrepared(sender: UIButton?) {
        if (prepared) {
            prepared = false
            preparedImage = UIImageView(image: #imageLiteral(resourceName: "EmptyCheckbox"))
        }
        else {
            prepared = true
            preparedImage = UIImageView(image: #imageLiteral(resourceName: "CheckedCheckbox"))
        }

    }
}
