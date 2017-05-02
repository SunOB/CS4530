//
//  TitleScreenController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class TitleScreenController: UIViewController, TitleScreenDelegate {
    
    //Change this to point to collection
    var playerController: CharacterCollectionController = CharacterCollectionController()
    var dmController: CampaignCollectionController = CampaignCollectionController()
    var dm : DungeonMaster = DungeonMaster()
    var player : Player = Player()
    
    var contentView : TitleScreen! {
        return view as! TitleScreen!
    }
    
    override func loadView() {
        super.loadView()
        view = TitleScreen()
        load()
        contentView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerController.player = player
        dmController.dm = dm
        title = "D&D 5e Helper"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dmMode(sender: UIButton!) {
        navigationController?.pushViewController(dmController, animated: true)
    }
    
    func playerMode(sender: UIButton!) {
        navigationController?.pushViewController(playerController, animated: true)
    }
    
    func save() {
        let defaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: player)
        defaults.setValue(data, forKey: "Player")
        
        let data2 = NSKeyedArchiver.archivedData(withRootObject: dm)
        defaults.setValue(data2, forKey: "DM")
        defaults.synchronize()
    }
    
    func load() {
        if let data = UserDefaults.standard.object(forKey: "Player") as? NSData {
            let _player = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! Player
            player = _player
        }
        
        if let data = UserDefaults.standard.object(forKey: "DM") as? NSData {
            let _dm = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! DungeonMaster
            dm = _dm
        }
    }
}

