//
//  TitleScreen.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol TitleScreenDelegate {
    func dmMode(sender: UIButton!)
    func playerMode(sender: UIButton!)
}

class TitleScreen: UIView {
    var delegate : TitleScreenDelegate!
    private var titleImage : UIImageView?
    
    private var dmButton : UIButton?
    private var playerButton : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleImage = UIImageView()
        dmButton = UIButton()
        playerButton = UIButton()
        
        titleImage?.image = #imageLiteral(resourceName: "DragonSymbol")
        
        dmButton?.addTarget(self, action: #selector(dmButtonPressed), for: .touchUpInside)
        playerButton?.addTarget(self, action: #selector(playerButtonPressed), for: .touchUpInside)
        
        backgroundColor = UIColor.white
        
        dmButton?.setTitle("Dungeon Master", for: .normal)
        dmButton?.backgroundColor = UIColor.blue
        //dmButton?.titleLabel?.textAlignment = NSTextAlignment.center
        
        playerButton?.setTitle("Player", for: .normal)
        playerButton?.backgroundColor = UIColor.blue
        //playerButton?.titleLabel?.textAlignment = NSTextAlignment.center
        
        addSubview(titleImage!)
        addSubview(dmButton!)
        addSubview(playerButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        var temp : CGRect
        
        (_, r) = r.divided(atDistance: h * 0.15, from: .minYEdge)

        (temp, r) = r.divided(atDistance: h * 0.4, from: .minYEdge)
        (_, temp) = temp.divided(atDistance: w * 0.1, from: .minXEdge)
        (_, temp) = temp.divided(atDistance: w * 0.1, from: .maxXEdge)

        (titleImage!.frame, temp) = temp.divided(atDistance: h * 0.5, from: .minYEdge)
        
        dmButton!.frame = CGRect(x: w * 0.2, y: titleImage!.frame.maxY + 10, width: w * 0.6, height: 75)
        
        playerButton!.frame = CGRect(x: w * 0.2, y: dmButton!.frame.maxY + 50, width: w * 0.6, height: 75 )
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func dmButtonPressed(sender: UIButton!) {
        delegate.dmMode(sender: sender)
    }
    
    func playerButtonPressed(sender: UIButton!) {
        delegate.playerMode(sender: sender)
    }
}
