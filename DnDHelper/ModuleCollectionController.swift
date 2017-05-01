//
//  ModuleCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/29/17.
//  Copyright © 2017 u0771753. All rights reserved.
//


import UIKit

protocol ModuleCollectionDelegate {
    func returnedFromEdit()
}

class ModuleCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, ModuleCellDelegate, ModuleContentDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var campaign : Campaign = Campaign()
    var _bestiary : Bestiary
    
    var moduleContentView: ModuleContentCollectionController?
    
    var completedVisable = true;
    var delegate : ModuleCollectionDelegate!;
    
    init(bestiary: Bestiary) {
        _bestiary = bestiary
        moduleContentView = ModuleContentCollectionController(bestiary: bestiary)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButtonItems([UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addModule)), UIBarButtonItem(title: "Hide Completed  |", style: .plain , target: self, action: #selector(toggleCompleted))], animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        moduleContentView?.delegate = self
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
        collectionView.register(ModuleCell.self, forCellWithReuseIdentifier: String(describing: ModuleCell.self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backPressed() {
        campaign.name = (self.navigationItem.titleView as! UITextField).text!
        delegate.returnedFromEdit()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 10) + 30)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !completedVisable {
            return campaign.currentModules.count
        }
        
        return campaign.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ModuleCell.self), for: indexPath) as! ModuleCell

        if (indexPath[1] < campaign.count) {
            var temp : Module
            if completedVisable {
                temp = campaign.getModule(num: campaign.getModule(num: indexPath[1]).num)
            }
            else {
                temp = campaign.getModule(num: campaign.currentModules[indexPath[1]].num)
            }
            cell.update(name: temp.name, shortDesc: temp.shortDescription, completed: temp.completed)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }

    func editCell(_num: Int) {
        campaign.name = (self.navigationItem.titleView as! UITextField).text!
        if !completedVisable {
            moduleContentView?.module = campaign.getModule(num: campaign.currentModules[_num].num)
        }
        else {
            moduleContentView?.module = campaign.getModule(num: _num)
        }
        _ = navigationController?.pushViewController(moduleContentView!, animated: true)
    }
    
    func deleteCell(_num: Int) {
        if !completedVisable {
            campaign.deleteModule(num: campaign.currentModules[_num].num)
        }
        else {
            campaign.deleteModule(num: _num)
        }
        collectionView.reloadData()
    }
    
    func updateName(_num: Int, name: String) {
        if !completedVisable {
            campaign.getModule(num: campaign.currentModules[_num].num).name = name
        }
        else {
            campaign.getModule(num: _num).name = name
        }
    }
    
    func updateShortDesc(_num: Int, shortDesc: String) {
        if !completedVisable {
            campaign.getModule(num: campaign.currentModules[_num].num).shortDescription = shortDesc
        }
        else {
            campaign.getModule(num: _num).shortDescription = shortDesc
        }
    }
    
    func addModule() {
        campaign.name = (self.navigationItem.titleView as! UITextField).text!
        let temp = campaign.addModule()
        moduleContentView?.module = temp
        _ = navigationController?.pushViewController(moduleContentView!, animated: true)
    }
    
    func toggleCompleted() {
        for cell in collectionView.visibleCells {
            cell.endEditing(false)
        }
        if completedVisable {
            completedVisable = false
            navigationItem.rightBarButtonItems?[1].title = "Show Completed  |"
        }
        else {
            completedVisable = true
            navigationItem.rightBarButtonItems?[1].title = "Hide Completed  |"
        }
        collectionView.reloadData()
    }
    
    func returnedFromEdit() {
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        (self.navigationItem.titleView as! UITextField).text = campaign.name
        collectionView.reloadData()
    }
    
    func toggleCompleteCell(_num: Int) {
        var temp : Module
        if !completedVisable {
            temp = campaign.getModule(num: campaign.currentModules[_num].num)
        }
        else {
            temp = campaign.getModule(num: _num)
        }
        if temp.completed {
            temp.completed = false
        }
        else {
            temp.completed = true
        }
        collectionView.reloadData()
    }
    
}
