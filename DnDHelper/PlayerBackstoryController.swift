//
//  PlayerBackstoryController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class PlayerBackstoryController: UIViewController {
    var contentView : PlayerBackstoryView! {
        return view as! PlayerBackstoryView!
    }
    
    var backstory = Backstory()
    
    override func loadView() {
        super.loadView()
        view = PlayerBackstoryView()
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(clickedBack)), animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Background Information"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickedBack(sender: UIBarButtonItem?) {
        backstory.charBackstory = contentView._backstory
        backstory.featsAndTraits = contentView._feats
        backstory.allies = contentView._allies
        backstory.treasure = contentView._treasure
        _ = navigationController?.popViewController(animated: true)
    }
    
    func update() {
        contentView.update(backstory: backstory.charBackstory, alliesAndOrg: backstory.allies, featsAndTraits: backstory.featsAndTraits, treasure: backstory.treasure)
    }
}
