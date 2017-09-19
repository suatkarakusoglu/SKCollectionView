//
//  SKCollectionViewXDelegate.swift
//  Zamekan
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension SKCollectionView: UICollectionViewDelegate
{
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedModel = self.skGetModelAtIndexPath(indexPath: indexPath)
        selectedModel.cellSelected()
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        guard let endReachedModel = self.endReachedModel else { return }
        let lastIndexSection = self.collectionDatas.count
        guard let lastIndexRow = self.collectionDatas.last?.models.count else { return }
        let lastIndexPath = IndexPath(row: lastIndexRow - 1, section: lastIndexSection - 1)
        let isLastItemGoingToRender = lastIndexPath == indexPath
        if isLastItemGoingToRender
        {
            let currentlyRenderingModel = self.collectionDatas[indexPath.section].models[indexPath.row]
            let isEndReachedModelRendering = currentlyRenderingModel === self.endReachedModel
            if isEndReachedModelRendering {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                self.skInsertModelAtTail(model: endReachedModel, scrollToIt: false)
                self.endReachedBlock?()
            })
        }
    }
    
    public func skSetEndless(loadingLength: CGFloat,  endReachedBlock: @escaping (() -> Void))
    {
        let endlessModelSize = { () -> CGSize in
            if self.skGetLayout().scrollDirection == .vertical
            {
                return CGSize(width: UIScreen.main.bounds.size.width, height: loadingLength)
                
            }else {
                return CGSize(width: loadingLength, height: UIScreen.main.bounds.size.height)
            }
        }()
        
        let endlessModel = SKEndlessCModel(loadingSize: endlessModelSize)
        self.skSetEndless(endReachedModel: endlessModel, endReachedBlock: endReachedBlock)
    }
    
    public func skSetEndless(endReachedModel: SKCollectionModel, endReachedBlock: @escaping (() -> Void))
    {
        self.endReachedModel = endReachedModel
        self.endReachedBlock = endReachedBlock
    }
    
    public func skEndReachedExecuted()
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            if let endReachedModel = self.endReachedModel
            {
                self.removeModel(modelToRemove: endReachedModel)
            }
        })
    }
}
