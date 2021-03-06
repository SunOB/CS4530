//
//  EncounterCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/28/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class EncounterCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CombatantDelegate, BestiaryCollectionDelegate, UIGestureRecognizerDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var encounter : Encounter = Encounter()        
    let invalidAlertController = UIAlertController(title: "Invalid Input", message: "You did not enter a valid number", preferredStyle: .alert)
    
    let bestiaryView: BestiaryCollectionController?
    
    var longPressGesture : UILongPressGestureRecognizer!
    var _bestiary : Bestiary
    
    init(bestiary: Bestiary) {
        _bestiary = bestiary
        bestiaryView = BestiaryCollectionController(bestiary: bestiary)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        invalidAlertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        bestiaryView?.delegate = self
        
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
        let temp = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        temp.textAlignment = .center
        temp.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        temp.adjustsFontSizeToFitWidth = true
        temp.borderStyle = UITextBorderStyle.line
        self.navigationItem.titleView = temp
        
        collectionView.dataSource = self
        collectionView.register(CombatantCell.self, forCellWithReuseIdentifier: String(describing: CombatantCell.self))
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        (self.navigationItem.titleView as! UITextField).text = encounter.name
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sortByInitiative(sender: UIBarButtonItem) {
        //Added a sleep so that the data model will be updated before the sort if the mouse was orignally in the initiative
        encounter.sortByInitiative()
        collectionView.reloadData()
    }
    
    func addCombatant(sender: UIBarButtonItem) {
        encounter.name = (self.navigationItem.titleView as! UITextField).text!
        _ = navigationController?.pushViewController(bestiaryView!, animated: true)
    }
    
    func backPressed() {
        encounter.name = (self.navigationItem.titleView as! UITextField).text!
        _ = navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return encounter.combatants.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CombatantCell.self), for: indexPath) as! CombatantCell
        if (indexPath[1] < encounter.combatants.count) {
            let temp = encounter.combatants[indexPath[1]]
            cell.updateCell(name: temp.name, initiative: temp.initiative, ac: temp.ac, hp: temp.hp, pg: temp.pg)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        return cell
    }
    
    func valueChanged(name: String, initiative: Int, ac: Int, hp: Int, pg: Int, _num: Int) {
        var totalChanges = 0
        
        if (encounter.combatants[_num].name != name) {
            totalChanges = totalChanges + 1
        }
        if (encounter.combatants[_num].ac != ac) {
            totalChanges = totalChanges + 1
        }
        if (encounter.combatants[_num].hp != hp) {
            totalChanges = totalChanges + 1
        }
        if (encounter.combatants[_num].pg != pg) {
            totalChanges = totalChanges + 1
        }
        if (encounter.combatants[_num].initiative != initiative) {
            totalChanges = totalChanges + 1
        }
        
        if (totalChanges <= 1) {
            encounter.combatants[_num].name = name
            encounter.combatants[_num].initiative = initiative
            encounter.combatants[_num].ac = ac
            encounter.combatants[_num].hp = hp
            encounter.combatants[_num].pg = pg
        }
        
        collectionView.reloadData()
    }
    
    func invalidInput() {
        if (self.presentedViewController == nil) {
            self.present(invalidAlertController, animated: true, completion: nil)
        }
    }
    
    func deletePressed(_num: Int) {
        encounter.combatants.remove(at: _num)
        collectionView.reloadData()
    }
    
    func addSelectedCombatant(num: Int, count: Int) {
        encounter.addCombatants(character: _bestiary.collection[num], count: count)
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
            for cell in collectionView.visibleCells {
                (cell as! CombatantCell).endEditing(false)
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
