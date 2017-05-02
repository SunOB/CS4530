//
//  CharacterCell.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate {
    func characterCellEdit(num: Int)
    func characterCellDelete(num: Int)
}

// The row should note if the game
// is in progress or if it has ended, who’s turn it is in that game (or has ended), and how
// many ships remain un-sunk for each player.
class CharacterCell: UICollectionViewCell {
    let fontSize : CGFloat = 7.5
    var delegate : CharacterCellDelegate!
    private var editButton : UIButton?
    private var deleteButton : UIButton?
    private var _name: UILabel?
    private var _genderRaceClass: UILabel?
    private var _level: UILabel?
    private var _game: UILabel?
    var num : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        editButton = UIButton()
        deleteButton = UIButton()
        _name = UILabel()
        _genderRaceClass = UILabel()
        _level = UILabel()
        _game = UILabel()

        editButton?.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        editButton?.setTitle("Edit", for: .normal)
        editButton?.contentHorizontalAlignment = .center
        editButton?.addTarget(self, action: #selector(clickedEdit), for: .touchUpInside)
        editButton?.backgroundColor = UIColor.red

        deleteButton?.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        deleteButton?.setTitle("Delete", for: .normal)
        deleteButton?.contentHorizontalAlignment = .center
        deleteButton?.addTarget(self, action: #selector(clickedDelete), for: .touchUpInside)
        deleteButton?.backgroundColor = UIColor.blue
        
        _name?.text = ""
        _genderRaceClass?.text = ""
        _level?.text = ""
        _game?.text = ""
        
        _name?.adjustsFontSizeToFitWidth = true
        _genderRaceClass?.adjustsFontSizeToFitWidth = true
        _level?.adjustsFontSizeToFitWidth = true
        _game?.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(_name!)
        contentView.addSubview(_genderRaceClass!)
        contentView.addSubview(_level!)
        contentView.addSubview(_game!)
        contentView.addSubview(editButton!)
        contentView.addSubview(deleteButton!)

        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickedEdit(sender: UIButton?) {
        delegate.characterCellEdit(num: num)
    }
    
    func clickedDelete(sender: UIButton?) {
        delegate.characterCellDelete(num: num)
    }
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        let h: CGFloat = r.height
        let w: CGFloat = r.width
        
        var temp: CGRect
        
        (_, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        (_, r) = r.divided(atDistance: w * 0.05, from: .minXEdge)
        (_, r) = r.divided(atDistance: w * 0.05, from: .maxXEdge)

        (temp, r) = r.divided(atDistance: w * 0.6, from: .minXEdge)
        
        (_name!.frame, temp) = temp.divided(atDistance: h * 0.3, from: .minYEdge)
        (_genderRaceClass!.frame, temp) = temp.divided(atDistance: h * 0.3, from: .minYEdge)
        
        (_level!.frame, temp) = temp.divided(atDistance: h * 0.3, from: .minYEdge)

        (_game!.frame, r) = r.divided(atDistance: h * 0.3, from: .minYEdge)
        (_, r) = r.divided(atDistance: h * 0.05, from: .minYEdge)
        
        (editButton!.frame, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, editButton!.frame) = editButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
        
        (deleteButton!.frame, r) = r.divided(atDistance: h * 0.2, from: .minYEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .maxXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: w * 0.025, from: .minXEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .minYEdge)
        (_, deleteButton!.frame) = deleteButton!.frame.divided(atDistance: h * 0.025, from: .maxYEdge)
    }
    
    func update(name: String, gender: String, race: String, charClass: String, level: Int, game: String) {
        _name?.text = name
        _genderRaceClass!.text = gender + " " + race + " " + charClass
        _level?.text = "Level " + String(level)
        _game?.text = "Game: " + game
    }
}
