//
//  Campaign.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import Foundation

class Campaign: NSObject, NSCoding {
    var name : String
    var shortDescription : String
    private var modules : [Module]
    
    var currentModules : [Module] {
        var temp : [Module] = []
        for module in modules {
            if !module.completed {
                temp.append(module)
            }
        }
        
        return temp
    }
    
    var count : Int {
        return modules.count
    }
    
    override init() {
        name = ""
        shortDescription = ""
        modules = []
        super.init()
    }
    
    //Encode data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(shortDescription, forKey: "ShortDescription")
        aCoder.encode(modules, forKey: "Modules")
    }
    
    //Decode data
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        shortDescription = aDecoder.decodeObject(forKey: "ShortDescription") as! String
        modules = aDecoder.decodeObject(forKey: "Modules") as! [Module]
    }
    
    func getModule(num : Int) -> Module {
        return modules[num]
    }
    
    func addModule() -> Module {
        let temp = Module()
        temp.num = modules.count
        modules.append(temp)
        return temp
    }
    
    func deleteModule (num: Int) {
        modules.remove(at: num)
        if num < modules.count {
            for i in num...modules.count {
                modules[i].num -= 1
            }
        }
    }
    
    
}
