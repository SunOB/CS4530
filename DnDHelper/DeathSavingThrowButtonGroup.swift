//
//  DeathSavingThrowButtonGroup.swift
//  DnDHelper
//
//  Created by u0771753 on 5/1/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol DeathSavingDelegate {
    func savesSelected(count: Int)
}

class ScreenBlocker: UIView {
    
    var delegate : DeathSavingDelegate!
    private var dashOneLabel : UILabel!
    private var dashTwoLabel : UILabel!

    private var buttonOne : UIButton!
    private var buttonTwo : UIButton!
    private var buttonThree : UIButton!
    
    var isDeath : Bool
    var numberSelected = 0
    
    init (frame: CGRect, death : Bool) {
        isDeath = death
        
        dashOneLabel = UILabel()
        dashTwoLabel = UILabel()
        
        buttonOne = UIButton()
        buttonTwo = UIButton()
        buttonThree = UIButton()
        
        dashOneLabel.text = "-"
        dashTwoLabel.text = "-"
        
        buttonOne.tag = 1
        buttonTwo.tag = 2
        buttonThree.tag = 3
        
        buttonOne.setBackgroundImage( #imageLiteral(resourceName: "EmptyCircle") , for: .normal)
        buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        buttonThree.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        buttonOne?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        buttonTwo?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        buttonThree?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(dashOneLabel!)
        addSubview(dashTwoLabel!)
        addSubview(buttonOne!)
        addSubview(buttonTwo!)
        addSubview(buttonThree!)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var r = bounds
        let w = bounds.width
        
        
    }
    
    func buttonPressed(sender: UIButton) {
        if sender.tag != numberSelected {
            numberSelected = sender.tag
            delegate.savesSelected(count: numberSelected)
        }
        else {
            numberSelected = numberSelected - 1
            delegate.savesSelected(count: numberSelected)
        }
        setNeedsLayout()
    }
    

    func updateButtons(selected: Int) {
        numberSelected = selected
        switch selected {
        case 1 :
            if isDeath {
                buttonOne.setBackgroundImage( #imageLiteral(resourceName: "DeathSaveFail") , for: .normal)
            }
            else {
                buttonOne.setBackgroundImage( #imageLiteral(resourceName: "DeathSaveSucess") , for: .normal)
            }
            buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
            buttonThree.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        case 2 :
            if isDeath {
                buttonOne.setBackgroundImage( #imageLiteral(resourceName: "DeathSaveFail") , for: .normal)
                buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "DeathSaveFail"), for: .normal)
            }
            else {
                buttonOne.setBackgroundImage( #imageLiteral(resourceName: "DeathSaveSucess") , for: .normal)
                buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "DeathSaveSucess"), for: .normal)
            }
            buttonThree.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        case 3 :
            if isDeath {
                buttonOne.setBackgroundImage( #imageLiteral(resourceName: "DeathSaveFail") , for: .normal)
                buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "DeathSaveFail"), for: .normal)
                buttonThree.setBackgroundImage(#imageLiteral(resourceName: "DeathSaveFail"), for: .normal)

            }
            else {
                buttonOne.setBackgroundImage( #imageLiteral(resourceName: "DeathSaveSucess") , for: .normal)
                buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "DeathSaveSucess"), for: .normal)
                buttonThree.setBackgroundImage(#imageLiteral(resourceName: "DeathSaveSucess"), for: .normal)
            }
        default :
            buttonOne.setBackgroundImage( #imageLiteral(resourceName: "EmptyCircle") , for: .normal)
            buttonTwo.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
            buttonThree.setBackgroundImage(#imageLiteral(resourceName: "EmptyCircle"), for: .normal)
        }
    }
    
}

