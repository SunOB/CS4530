//
//  BestiaryCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/27/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

protocol BestiaryCollectionDelegate {
    func addSelectedCombatant(num: Int, count: Int)
}

class BestiaryCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BestiaryEntryDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var bestiary : Bestiary = Bestiary()
    
    var delegate : BestiaryCollectionDelegate!
    
    let invalidAlertController = UIAlertController(title: "Invalid Input", message: "You did not enter a valid number", preferredStyle: .alert)
    let selectAlertController = UIAlertController(title: "How Many?", message: "", preferredStyle: .alert)
    var longPressGesture : UILongPressGestureRecognizer!
    
    var lastSelected : Int!
    
    init(bestiary: Bestiary) {
        self.bestiary = bestiary
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        invalidAlertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        selectAlertController.addTextField { (textField: UITextField!) in
            textField.keyboardType = UIKeyboardType.numberPad
        }
        selectAlertController.textFields?[0].delegate = self
        selectAlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        selectAlertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            var _count = Int((self.selectAlertController.textFields?[0].text)!)
            if (_count == nil || (self.selectAlertController.textFields?[0].text)! == "") {
                _count = 0
            }
            self.delegate.addSelectedCombatant(num: self.lastSelected, count: _count!)
            _ = self.navigationController?.popViewController(animated: true)
        }))
    
            

        
        view = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButton(UIBarButtonItem(title: "New Bestiary Entry", style: .plain, target: self, action: #selector(newEntry)), animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        longPressGesture.delegate = self
        self.collectionView.addGestureRecognizer(longPressGesture)
        navigationController?.title = "Bestiary"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.register(BestiaryEntryCell.self, forCellWithReuseIdentifier: String(describing: BestiaryEntryCell.self))
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newEntry(sender: UIBarButtonItem) {
        bestiary.collection.append(BestiaryEntry())
        collectionView.reloadData()
    }
    
    func backPressed() {
        _ = navigationController?.popViewController(animated: true)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestiary.collection.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestiaryEntryCell.self), for: indexPath) as! BestiaryEntryCell
        if (indexPath[1] < bestiary.collection.count) {
            let temp = bestiary.collection[indexPath[1]]
            cell.updateCell(name: temp.name, ac: temp.ac, hp: temp.hp, pg: temp.pg)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        return cell
    }
    
    func valueChanged(name: String, ac: Int, hp: Int, pg: Int, _num: Int) {
        //Hacky way to fix swapping bug, actual issue probably caused by the function above which tries to update the cell data when dragging the cell.
        
        var totalChanges = 0
        
        if (bestiary.collection[_num].name != name) {
            totalChanges = totalChanges + 1
        }
        if (bestiary.collection[_num].ac != ac) {
            totalChanges = totalChanges + 1
        }
        if (bestiary.collection[_num].hp != hp) {
            totalChanges = totalChanges + 1
        }
        if (bestiary.collection[_num].pg != pg) {
            totalChanges = totalChanges + 1
        }
        
        if (totalChanges <= 1) {
            bestiary.collection[_num].name = name
            bestiary.collection[_num].ac = ac
            bestiary.collection[_num].hp = hp
            bestiary.collection[_num].pg = pg
        }
        
        collectionView.reloadData()
    }
    
    func invalidInput() {
        if (self.presentedViewController == nil) {
            self.present(invalidAlertController, animated: true, completion: nil)
        }
    }
    
    func entrySelected(_num: Int) {
        lastSelected = _num
        if (self.presentedViewController == nil) {
            self.present(selectAlertController, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var source = sourceIndexPath[1]
        var dest = destinationIndexPath[1]
        if (source < dest) {
            dest = dest + 1
        }
        
        bestiary.collection.insert(bestiary.collection[source], at: dest)
        
        
        if (source > dest) {
            source = source + 1
        }
        
        bestiary.collection.remove(at: source)
        
        collectionView.reloadData()
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            for cell in collectionView.visibleCells {
                (cell as! BestiaryEntryCell).endEditing(false)
            }
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
