//
//  Description.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Description: NSObject, NSCoding, ModuleContent {
    var title : String
    var text : String
    
    override init() {
        title = ""
        text = ""
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(text, forKey: "Text")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "Title") as! String
        text = aDecoder.decodeObject(forKey: "Text") as! String
    }
}
