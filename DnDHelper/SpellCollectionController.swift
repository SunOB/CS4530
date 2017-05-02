//
//  SpellCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/26/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class SpellbookCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SpellbookViewDelegate, SpellCellDelegate {
    var scrollView : UIScrollView! {
        return view as! UIScrollView!
    }
    
    var spellbookView = SpellbookView()
    
    var spellBook = Spellbook()
    
    func update(level : Int, _num : Int, prepared: Bool) {
        spellBook.spells[level][_num].isPrepared = prepared
        spellbookView.spells[level].reloadData()
        
    }
    
    func update(level : Int, _num : Int, name : String) {
        spellBook.spells[level][_num].spellName = name
        spellbookView.spells[level].reloadData()
    }
    
    func delete(level : Int, _num: Int) {
        for cell in spellbookView.spells[level].visibleCells {
            cell.endEditing(false)
        }
        spellBook.spells[level].remove(at: _num)
        spellbookView.spells[level].reloadData()
    }

    
    func addSpell(level: Int) {
        let temp = Spell()
        spellBook.spells[level].append(temp)
        spellbookView.spells[level].reloadData()
    }
    
    override func loadView() {
        super.loadView()
        view = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.backgroundColor = UIColor.white
        spellbookView.delegate = self
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(clickedBack)), animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Spellbook"
        
        
        for i in 0..<spellbookView.spells.count {
            spellbookView.spells[i].delegate = self
            spellbookView.spells[i].dataSource = self
            spellbookView.spells[i].register(SpellCell.self, forCellWithReuseIdentifier: String(describing: SpellCell.self))
        }
        
        scrollView.addSubview(spellbookView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: scrollView.bounds.height * 4)
        spellbookView.bounds.size = scrollView.contentSize
        spellbookView.center = CGPoint(x: scrollView.center.x, y: scrollView.center.y * 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: spellbookView.spells[0].frame.width, height: spellbookView.spells[0].frame.height / 5)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spellBook.spells[collectionView.tag].count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpellCell.self), for: indexPath) as! SpellCell
        
        let temp = spellBook.spells[collectionView.tag][indexPath[1]]
        
        cell.updateCell(name: temp.spellName, isPrepared: temp.isPrepared)
        cell.num = indexPath[1]
        cell.level = collectionView.tag
        cell.delegate = self
            
        cell.layer.borderColor = UIColor.black.cgColor
            
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickedBack(sender: UIBarButtonItem?) {
        spellBook.spellAttackBonus = spellbookView._spellAttackBonus
        spellBook.spellcastingAbility = spellbookView._spellAbility
        spellBook.spellcastingClass = spellbookView._spellClass
        spellBook.spellSaveDC = spellbookView._spellSaveDC
        spellBook.spellSlotsCur = spellbookView._currentSlots
        spellBook.spellSlotsTotal = spellbookView._totalSlots
        _ = navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        spellbookView.update(spellcastingClass: spellBook.spellcastingClass, spellcastingAbility: spellBook.spellcastingAbility, spellAttackBonus: spellBook.spellAttackBonus, spellSaveDC: spellBook.spellSaveDC, spellSlotsCur: spellBook.spellSlotsCur, spellSlotsTotal: spellBook.spellSlotsTotal)
        
        for spellCollection in spellbookView.spells {
            spellCollection.reloadData()
        }
    }
}
