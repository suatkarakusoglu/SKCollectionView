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
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentModel = self.skGetModelAtIndexPath(indexPath: indexPath)
        currentModel.ownerSKCollectionView = self
        if let boundCollectionCell = currentModel.boundCollectionCell {
            return boundCollectionCell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currentModel.cellTypeIdentifier(), for: indexPath) as? SKCollectionCell
        {
            // Delay it so that constraints are loaded before.
            let delayApplyMilliSeconds = DispatchTimeInterval.nanoseconds(1)
            let runAfterTime = DispatchTime.now() + delayApplyMilliSeconds
            DispatchQueue.main.asyncAfter(deadline: runAfterTime) {
                cell.applyModel(kollectionModel: currentModel)
                if currentModel.shouldBindToCell
                {
                    currentModel.boundCollectionCell = cell
                }
            }
            return cell
        }
        
        return UICollectionViewCell()
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
        let activeReusableModel = { () -> SKCollectionReusableModel? in
            let currentSection = self.collectionDatas[indexPath.section]
            if kind == UICollectionElementKindSectionHeader {
                return currentSection.headerModel
            }else{
                return currentSection.footerModel
            }
        }()
        
        guard let currentReusableModel = activeReusableModel else { return UICollectionReusableView() }
        
        if let boundView = currentReusableModel.boundView
        {
            return boundView
        }
        
        if let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: currentReusableModel.viewTypeIdentifier(), for: indexPath) as? SKCollectionReusableView {
            supplementaryView.applyReusableModel(reusableModel: currentReusableModel)
            if currentReusableModel.shouldBindToView {
                currentReusableModel.boundView = supplementaryView
            }
            return supplementaryView
        }
    
        return UICollectionReusableView()
    }
}
