//
//  ModuleContentCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/28/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class ModuleContentCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DescriptionCellDelegate, EncounterCellDelegate, UIGestureRecognizerDelegate  {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var module : Module = Module()
    
    let addAlertController = UIAlertController(title: "Choose a panel type", message: "", preferredStyle: .alert)
    
    var encounterView: EncounterCollectionController = EncounterCollectionController()
    var descriptionView : DescriptionController = DescriptionController()
    
    var longPressGesture : UILongPressGestureRecognizer!
    
    override func loadView() {
        super.loadView()
        addAlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        addAlertController.addAction(UIAlertAction(title: "Encounter", style: UIAlertActionStyle.default, handler:
        { (UIAlertAction) -> Void in
            let temp = Encounter()
            self.module.modulePanels.append(temp)
            self.encounterView.encounter = temp
            _ = self.navigationController?.pushViewController(self.encounterView, animated: true)
            
        }))
        addAlertController.addAction(UIAlertAction(title: "Description", style: UIAlertActionStyle.default, handler:
            { (UIAlertAction) -> Void in
                let temp = Description()
                self.module.modulePanels.append(temp)
                self.descriptionView.desc = temp
                _ = self.navigationController?.pushViewController(self.descriptionView, animated: true)
        }))
        
        view = CollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPanel)), animated: true)
        
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
        collectionView.register(EncounterCell.self, forCellWithReuseIdentifier: String(describing: EncounterCell.self))
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: String(describing: DescriptionCell.self))
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        (self.navigationItem.titleView as! UITextField).text = module.name
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backPressed() {
        module.name = (self.navigationItem.titleView as! UITextField).text!
        _ = navigationController?.popViewController(animated: true)
    }
    
    func addPanel() {
        module.name = (self.navigationItem.titleView as! UITextField).text!
        if (self.presentedViewController == nil) {
            self.present(addAlertController, animated: true, completion: nil)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return module.modulePanels.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if module.modulePanels[indexPath[1]] is Encounter {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EncounterCell.self), for: indexPath) as! EncounterCell
            cell.num = indexPath[1]
            
            let enc = module.modulePanels[indexPath[1]] as! Encounter
            cell.delegate = self
            cell.update(name: enc.name, combatantsList: enc.combatantText)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DescriptionCell.self), for: indexPath) as! DescriptionCell
            cell.num = indexPath[1]
            
            let desc = module.modulePanels[indexPath[1]] as! Description
            cell.delegate = self
            cell.update(title: desc.title, desc: desc.text)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    func encDeleteCell(_num: Int) {
        module.modulePanels.remove(at: _num)
        collectionView.reloadData()
    }
    func encEditCell(_num: Int) {
        module.name = (self.navigationItem.titleView as! UITextField).text!
        encounterView.encounter = module.modulePanels[_num] as! Encounter
        _ = navigationController?.pushViewController(encounterView, animated: true)
    }
    func descDeleteCell(_num: Int) {
        module.modulePanels.remove(at: _num)
        collectionView.reloadData()
    }
    func descEditCell(_num: Int) {
        module.name = (self.navigationItem.titleView as! UITextField).text!
        descriptionView.desc = module.modulePanels[_num] as! Description
        _ = navigationController?.pushViewController(descriptionView, animated: true)
    }
    
    // Drag and Drop Logic
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var source = sourceIndexPath[1]
        var dest = destinationIndexPath[1]
        
        if (source < dest) {
            dest = dest + 1
        }
        
        module.modulePanels.insert(module.modulePanels[source], at: dest)
        
        if (source > dest) {
            source = source + 1
        }
        
        module.modulePanels.remove(at: source)
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
    
    func update(encounter: Encounter) {
        collectionView.reloadData()
    }
}
