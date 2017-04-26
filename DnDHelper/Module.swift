//
//  Module.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Module: NSObject, NSCoding {
    var name : String
    var shortDescription : String
    var modulePanels : [ModuleContent]
    var completed : Bool
    
    override init() {
        name = ""
        shortDescription = ""
        modulePanels = []
        completed = false
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(shortDescription, forKey: "ShortDescription")
        aCoder.encode(modulePanels, forKey: "ModulePanels")
        aCoder.encode(completed, forKey: "Completed")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        shortDescription = aDecoder.decodeObject(forKey: "ShortDescription") as! String
        modulePanels = aDecoder.decodeObject(forKey: "ModulePanels") as! [ModuleContent]
        completed = aDecoder.decodeBool(forKey: "Completed")
    }
}
