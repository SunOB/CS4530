//
//  CharacterCollectionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/22/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class CharacterCollectionController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView : CollectionView {return view as! CollectionView}
    var collectionViewFlowLayout : UICollectionViewFlowLayout { return collectionView.collectionViewLayout as! UICollectionViewFlowLayout }
    var characters : [Character] = []
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
