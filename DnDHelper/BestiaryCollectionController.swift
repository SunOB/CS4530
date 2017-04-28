//
//  BestiaryCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/27/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class BestiaryCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BestiaryEntryDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var bestiary : [BestiaryEntry] = []
    
    let alertController = UIAlertController(title: "Invalid Input", message: "You did not enter a valid number", preferredStyle: .alert)
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.isTranslucent = false
        view = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        alertController.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        navigationItem.setRightBarButton(UIBarButtonItem(title: "New Entry", style: .plain, target: self, action: #selector(newEntry)), animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
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
        bestiary.append(BestiaryEntry())
        collectionView.reloadData()
    }
    
    func backPressed() {
        _ = navigationController?.popViewController(animated: true)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestiary.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestiaryEntryCell.self), for: indexPath) as! BestiaryEntryCell
        if (indexPath[1] < bestiary.count) {
            let temp = bestiary[indexPath[1]]
            cell.updateCell(name: temp.name, ac: temp.ac, hp: temp.hp, pg: temp.pg)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        return cell
    }
    
    func valueChanged(name: String, ac: Int, hp: Int, pg: Int, _num: Int) {
        bestiary[_num].name = name
        bestiary[_num].ac = ac
        bestiary[_num].hp = hp
        bestiary[_num].pg = pg
        collectionView.reloadData()
    }
    
    func invalidInput() {
        self.present(alertController, animated: true, completion: nil)
    }
    
}
