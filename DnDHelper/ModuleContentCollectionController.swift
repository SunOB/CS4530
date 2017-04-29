//
//  ModuleContentCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/28/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class ModuleContentCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DescriptionCellDelegate, EncounterCellDelegate, UIGestureRecognizerDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var module : Module = Module()
    
    let invalidAlertController = UIAlertController(title: "Invalid Input", message: "You did not enter a valid number", preferredStyle: .alert)
    
    var bestiaryView: BestiaryCollectionController = BestiaryCollectionController()
    
    var longPressGesture : UILongPressGestureRecognizer!
    
    override func loadView() {
        super.loadView()
        invalidAlertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        bestiaryView.bestiary = bestiary
        
        bestiaryView.delegate = self
        
        view = CollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButtonItems([UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addCombatant)), UIBarButtonItem(title: "Sort  |", style: .plain , target: self, action: #selector(sortByInitiative))], animated: true)
        
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        
        // Drag and Drop Logic
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        longPressGesture.delegate = self
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.title = encounter.name
        let temp = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        temp.baselineAdjustment = .alignCenters
        temp.text = encounter.name
        temp.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        temp.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = temp
        
        collectionView.dataSource = self
        collectionView.register(CombatantCell.self, forCellWithReuseIdentifier: String(describing: CombatantCell.self))
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      func addCombatant(sender: UIBarButtonItem) {
        _ = navigationController?.pushViewController(bestiaryView, animated: true)
    }
    
    func backPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return module.modulePanels.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CombatantCell.self), for: indexPath) as! CombatantCell
        cell.num = indexPath[1]
        cell.delegate = self
        return cell
    }
    
    func valueChanged(name: String, initiative: Int, ac: Int, hp: Int, pg: Int, _num: Int) {
        encounter.combatants[_num].name = name
        encounter.combatants[_num].initiative = initiative
        encounter.combatants[_num].ac = ac
        encounter.combatants[_num].hp = hp
        encounter.combatants[_num].pg = pg
        collectionView.reloadData()
    }
    
    func invalidInput() {
        if (self.presentedViewController == nil) {
            self.present(invalidAlertController, animated: true, completion: nil)
        }
    }
    
    func encDeleteCell(_num: Int) {
        encounter.combatants.remove(at: _num)
        collectionView.reloadData()
    }
    func encEditCell(_num: Int) {
        encounter.combatants.remove(at: _num)
        collectionView.reloadData()
    }
    func descDeleteCell(_num: Int) {
        encounter.combatants.remove(at: _num)
        collectionView.reloadData()
    }
    func descDeleteCell(_num: Int) {
        encounter.combatants.remove(at: _num)
        collectionView.reloadData()
    }
    
    func addSelectedCombatant(num: Int, count: Int) {
        encounter.addCombatants(character: bestiary.collection[num], count: count)
    }
    
    // Drag and Drop Logic
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var source = sourceIndexPath[1]
        var dest = destinationIndexPath[1]
        
        if (source < dest) {
            dest = dest + 1
        }
        
        encounter.combatants.insert(encounter.combatants[source], at: dest)
        
        if (source > dest) {
            source = source + 1
        }
        
        encounter.combatants.remove(at: source)
        collectionView.reloadData()
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}
