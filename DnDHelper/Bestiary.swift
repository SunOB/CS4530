//
//  Bestiary.swift
//  DnDHelper
//
//  Created by u0771753 on 4/28/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Bestiary: NSObject, NSCoding {
    var collection : [BestiaryEntry]
    
    override init() {
        collection = []
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(collection, forKey: "Bestiary")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        collection = aDecoder.decodeObject(forKey: "Bestiary") as! [BestiaryEntry]
    }
}
