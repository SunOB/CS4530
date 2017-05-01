//
//  CampaignCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/30/17.
//  Copyright © 2017 u0771753. All rights reserved.
//


import UIKit

class CampaignCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, CampaignCellDelegate, ModuleCollectionDelegate {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var dm : DungeonMaster = DungeonMaster()
    
    var moduleCollectionView: ModuleCollectionController?
    
    override init(nibName: String? , bundle: Bundle?) {
        moduleCollectionView = ModuleCollectionController(bestiary: dm.bestiary)
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addCampaign)), animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed)), animated: true)
        
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        moduleCollectionView?.delegate = self
        self.title = "Campaigns"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.register(CampaignCell.self, forCellWithReuseIdentifier: String(describing: CampaignCell.self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 10) + 30)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dm.campaigns.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CampaignCell.self), for: indexPath) as! CampaignCell
        
        if (indexPath[1] < dm.campaigns.count) {
            let temp = dm.campaigns[indexPath[1]]
            cell.update(name: temp.name, shortDesc: temp.shortDescription)
        }
        cell.num = indexPath[1]
        cell.delegate = self
        
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func editCell(_num: Int) {
        moduleCollectionView?.campaign = dm.campaigns[_num]
        _ = navigationController?.pushViewController(moduleCollectionView!, animated: true)
    }
    
    func deleteCell(_num: Int) {
        dm.campaigns.remove(at: _num)
        collectionView.reloadData()
    }
    
    func updateName(_num: Int, name: String) {
        dm.campaigns[_num].name = name
    }
    
    func updateShortDesc(_num: Int, shortDesc: String) {
        dm.campaigns[_num].shortDescription = shortDesc
    }
    
    func addCampaign() {
        let temp = Campaign()
        dm.campaigns.append(temp)
        moduleCollectionView?.campaign = temp
        _ = navigationController?.pushViewController(moduleCollectionView!, animated: true)
    }
    
    func returnedFromEdit() {
        collectionView.reloadData()
    }
}
