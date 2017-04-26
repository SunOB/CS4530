//
//  CharacterSheetController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class CharacterSheetController: UIViewController, CharacterSheetDelegate {
    var contentView : CharacterSheet! {
        return view as! CharacterSheet!
    }
    
    override func loadView() {
        super.loadView()
        view = CharacterSheet()
        contentView.delegate = self
         navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(clickedBack)), animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "D&D 5e All-In-One"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backstoryPressed(sender: UIButton!) {
        
    }
    
    func spellbookPressed(sender: UIButton!) {
        
    }
    
    func clickedBack(sender: UIBarButtonItem?) {
        _ = navigationController?.popViewController(animated: true)
    }
}
