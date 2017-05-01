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
    var playerController: CharacterSheetController = CharacterSheetController()
    var dmController: CampaignCollectionController = CampaignCollectionController()
    
    var contentView : TitleScreen! {
        return view as! TitleScreen!
    }
    
    override func loadView() {
        super.loadView()
        view = TitleScreen()
        contentView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
}

