//
//  SKCollectionViewXDataSource.swift
//  Zamekan
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension SKCollectionView: UICollectionViewDataSource
{
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let currentModel = self.skGetModelAtIndexPath(indexPath: indexPath)
        let reuseIdentifier = currentModel.xibTypeIdentifier()
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let skCollectionCell = collectionCell as? SKCollectionCell else { return UICollectionViewCell() }

        skCollectionCell.applyModel(kollectionModel: currentModel)
        currentModel.boundCollectionCell = skCollectionCell
        currentModel.ownerSKCollectionView = self
        return skCollectionCell
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.collectionDatas.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.collectionDatas[section].models.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let currentSection = self.collectionDatas[indexPath.section]
        let activeReusableModel = (kind == UICollectionElementKindSectionHeader) ? currentSection.headerModel : currentSection.footerModel

        guard let currentReusableModel = activeReusableModel else { return UICollectionReusableView() }
        
        let reuseIdentifier = currentReusableModel.viewTypeIdentifier()
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let skSupplementaryView = supplementaryView as? SKCollectionReusableView else { return UICollectionReusableView() }
        
        skSupplementaryView.applyReusableModel(reusableModel: currentReusableModel)
        currentReusableModel.boundView = skSupplementaryView
        
        return skSupplementaryView
    }
}
