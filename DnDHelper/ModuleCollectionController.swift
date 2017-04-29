//
//  ModuleCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/29/17.
//  Copyright © 2017 u0771753. All rights reserved.
//


import UIKit

class ModuleCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, ModuleCellDelegate, ModuleContentDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var campaign : Campaign = Campaign()
    
    var moduleContentView: ModuleContentCollectionController = ModuleContentCollectionController()
    
    var completedVisable = true;
    
    override func loadView() {
        super.loadView()
        view = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButtonItems([UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addModule)), UIBarButtonItem(title: "Hide Completed  |", style: .plain , target: self, action: #selector(toggleCompleted))], animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        moduleContentView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.register(ModuleCell.self, forCellWithReuseIdentifier: String(describing: ModuleCell.self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // TODO: Sizing the hidden cells is not working
        
        if !completedVisable && campaign.modules[indexPath[1]].completed {
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 10) + 30)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaign.modules.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ModuleCell.self), for: indexPath) as! ModuleCell

        if (indexPath[1] < campaign.modules.count) {
            let temp = campaign.modules[indexPath[1]]
            cell.update(name: temp.name)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        
        cell.layer.borderColor = UIColor.black.cgColor
        
        if !completedVisable && campaign.modules[indexPath[1]].completed {
            cell.isHidden = true
        }
        else {
            cell.isHidden = false
        }
        
        return cell
    }

    func editCell(_num: Int) {
        moduleContentView.module = campaign.modules[_num]
        _ = navigationController?.pushViewController(moduleContentView, animated: true)
    }
    
    func deleteCell(_num: Int) {
        campaign.modules.remove(at: _num)
        collectionView.reloadData()
    }
    
    func updateName(_num: Int, name: String) {
        campaign.modules[_num].name = name
    }
    
    func updateShortDesc(_num: Int, shortDesc: String) {
        campaign.modules[_num].shortDescription = shortDesc
    }
    
    func addModule() {
        let temp = Module()
        campaign.modules.append(temp)
        moduleContentView.module = temp
        _ = navigationController?.pushViewController(moduleContentView, animated: true)
    }
    
    func toggleCompleted() {
        if completedVisable {
            completedVisable = false
        }
        else {
            completedVisable = true
        }
        collectionView.reloadData()
    }
    
    func returnedFromEdit() {
        collectionView.reloadData()
    }
    
    func toggleCompleteCell(_num: Int) {
        if campaign.modules[_num].completed {
            campaign.modules[_num].completed = false
        }
        else {
            campaign.modules[_num].completed = true
        }
    }
    
}
