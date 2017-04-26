//
//  Sound.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Sound: NSObject, NSCoding {
    var name : String

    override init() {
        name = ""
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
    }
}
