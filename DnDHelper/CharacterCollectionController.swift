//
//  CharacterCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class CharacterCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CharacterCellDelegate, CharacterControllerDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    
    public var player : Player = Player()
    
    var characterSheetController: CharacterSheetController?
    
    override func loadView() {
        super.loadView()
        characterSheetController = CharacterSheetController()
        view = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addCharacter)), animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        
        characterSheetController?.delegate = self
        
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        //characterSheetController?.delegate = self
        self.title = "Characters"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: String(describing: CharacterCell.self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player.characters.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCell.self), for: indexPath) as! CharacterCell
        
        if (indexPath[1] < player.characters.count) {
            let temp = player.characters[indexPath[1]]
            cell.update(name: temp.name, gender: temp.gender, race: temp.race, charClass: temp.charClass, level: temp.level, game: temp.game)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func addCharacter() {
        let temp = Character()
        player.characters.append(temp)
        characterSheetController?.character = temp
        navigationController?.pushViewController(characterSheetController!, animated: true)
    }
    
    
    func characterCellEdit(num: Int) {
        characterSheetController?.character = player.characters[num]
        navigationController?.pushViewController(characterSheetController!, animated: true)
    }
    
    func characterCellDelete(num: Int) {
        player.characters.remove(at: num)
        collectionView.reloadData()
    }
    
    func backFromSheet() {
        collectionView.reloadData()
    }

}


