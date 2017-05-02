//
//  Player.swift
//  DnDHelper
//
//  Created by u0771753 on 5/1/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Player: NSObject, NSCoding  {
    var characters : [Character]
    
    override init() {
        characters = []
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(characters, forKey: "Characters")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        characters = aDecoder.decodeObject(forKey: "Characters") as! [Character]
    }
}
