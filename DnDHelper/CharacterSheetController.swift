//
//  CharacterSheetController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class CharacterSheetController: UIViewController, CharacterSheetDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, StatCellDelegate, SavingThrowCellDelegate, SkillCellDelegate, AttackCellDelegate {
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
        
        characterView.attackCollection?.delegate = self
        characterView.attackCollection?.dataSource = self
        characterView.attackCollection?.register(AttackCell.self, forCellWithReuseIdentifier: String(describing: AttackCell.self))
        characterView.attackCollection?.tag = 3
        
        scrollView.addSubview(characterView)
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: scrollView.bounds.height * 3)
        characterView.bounds.size = scrollView.contentSize
        characterView.center = CGPoint(x: scrollView.center.x, y: scrollView.center.y * 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
           return CGSize(width: characterView.stats!.frame.width, height: characterView.stats!.frame.height / 6)
        }
        else if collectionView.tag == 1 {
            return CGSize(width: characterView.savingThrows!.frame.width, height: characterView.savingThrows!.frame.height / 6)
        }
        else if collectionView.tag == 2{
            return CGSize(width: characterView.skills!.frame.width, height: characterView.skills!.frame.height / 9)
        }
        else {
            return CGSize(width: characterView.attackCollection!.frame.width, height: characterView.attackCollection!.frame.height / 4)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return character.attributes.count
        }
        else if collectionView.tag == 1 {
            return character.savingThrows.count
        }
        else if collectionView.tag == 2 {
            return character.skills.count
        }
        else {
            return character.attacks.count
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
            
            return cell
        }
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SkillCell.self), for: indexPath) as! SkillCell
            
            cell.updateCell(stat: character.skillLabels[indexPath[1]], value: character.skills[indexPath[1]], proficient: character.skillProficiencies[indexPath[1]])
            cell.num = indexPath[1]
            cell.delegate = self
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AttackCell.self), for: indexPath) as! AttackCell
            
            let temp = character.attacks[indexPath[1]]
            
            cell.updateCell(name: temp.name, attackBonus: temp.attackBonus, damageDie: temp.damageDie, damageDieCount: temp.damageDieCount, damageBonus: temp.damageBonus, type: temp.type, bonusEffects: temp.bonusEffects)
            cell.num = indexPath[1]
            cell.delegate = self
            
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
    
    func attackChanged(_num: Int, name: String, attackBonus : Int, damageDie : Int, damageDieCount : Int, damageBonus : Int, type : String, bonusEffects : String) {
        let temp = character.attacks[_num]
        temp.name = name
        temp.attackBonus = attackBonus
        temp.damageDie = damageDie
        temp.damageDieCount = damageDieCount
        temp.damageBonus = damageBonus
        temp.type = type
        temp.bonusEffects = bonusEffects
        
        characterView.attackCollection?.reloadData()
    }
    
    func addAttack() {
        character.attacks.append(Attack())
        characterView.attackCollection?.reloadData()
    }
}
