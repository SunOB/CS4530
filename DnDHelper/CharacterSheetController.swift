//
//  CharacterSheetController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class CharacterSheetController: UIViewController, CharacterSheetDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, StatCellDelegate, SavingThrowCellDelegate, SkillCellDelegate {
    var scrollView : UIScrollView! {
        return view as! UIScrollView!
    }
    
    var characterView = CharacterSheet()
    
    var character : Character = Character()
    
    var backstory : PlayerBackstoryController = PlayerBackstoryController()
    
    override func loadView() {
        super.loadView()
        view = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.backgroundColor = UIColor.white
        characterView.charDelegate = self
         navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(clickedBack)), animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
        
        //Work on scrollview shit
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Character Sheet"
        
        characterView.stats?.delegate = self
        characterView.stats?.dataSource = self
        characterView.stats?.register(StatCell.self, forCellWithReuseIdentifier: String(describing: StatCell.self))
        characterView.stats?.tag = 0
        
        characterView.savingThrows?.delegate = self
        characterView.savingThrows?.dataSource = self
        characterView.savingThrows?.register(SavingThrowCell.self, forCellWithReuseIdentifier: String(describing: SavingThrowCell.self))
        characterView.savingThrows?.tag = 1
        
        characterView.skills?.delegate = self
        characterView.skills?.dataSource = self
        characterView.skills?.register(SkillCell.self, forCellWithReuseIdentifier: String(describing: SkillCell.self))
        characterView.skills?.tag = 2
        
        scrollView.addSubview(characterView)
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: scrollView.bounds.height * 2)
        characterView.bounds.size = scrollView.contentSize
        characterView.center = CGPoint(x: scrollView.center.x, y: scrollView.center.y * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
           return CGSize(width: characterView.stats!.frame.width, height: characterView.stats!.frame.height / 6)
        }
        else if collectionView.tag == 1 {
            return CGSize(width: characterView.savingThrows!.frame.width, height: characterView.savingThrows!.frame.height / 6)
        }
        else {
            return CGSize(width: characterView.skills!.frame.width, height: characterView.skills!.frame.height / 9)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return character.attributes.count
        }
        else if collectionView.tag == 1 {
            return character.savingThrows.count
        }
        else {
            return character.skills.count
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StatCell.self), for: indexPath) as! StatCell
            
            cell.updateCell(stat: character.attributeLabels[indexPath[1]], value: character.attributes[indexPath[1]])
            cell.num = indexPath[1]
            cell.delegate = self
            
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        }
        else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SavingThrowCell.self), for: indexPath) as! SavingThrowCell
            
            cell.updateCell(stat: character.attributeLabels[indexPath[1]], value: character.savingThrows[indexPath[1]], proficient: character.savingThrowProficiencies[indexPath[1]])
            cell.num = indexPath[1]
            cell.delegate = self
            
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SkillCell.self), for: indexPath) as! SkillCell
            
            cell.updateCell(stat: character.skillLabels[indexPath[1]], value: character.skills[indexPath[1]], proficient: character.skillProficiencies[indexPath[1]])
            cell.num = indexPath[1]
            cell.delegate = self
            
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backstoryPressed(sender: UIButton!) {
        navigationController?.pushViewController(backstory, animated: true)
    }
    
    func spellbookPressed(sender: UIButton!) {
        
    }
    
    func clickedBack(sender: UIBarButtonItem?) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func statChanged(_num: Int, value: Int) {
        character.attributes[_num] = value
    }
    
    func savingThrowChanged(num: Int, value: Int) {
        character.savingThrows[num] = value
    }
    
    func proficiencyChanged(num: Int) {
        if character.savingThrowProficiencies[num] {
            character.savingThrowProficiencies[num] = false
        }
        else {
            character.savingThrowProficiencies[num] = true
        }
        characterView.savingThrows?.reloadData()
    }
    
    func skillChanged(num: Int, value: Int) {
        character.skills[num] = value
    }
    
    func skillProficiencyChanged(num: Int) {
        if character.skillProficiencies[num] {
            character.skillProficiencies[num] = false
        }
        else {
            character.skillProficiencies[num] = true
        }
        characterView.skills?.reloadData()
    }
}
