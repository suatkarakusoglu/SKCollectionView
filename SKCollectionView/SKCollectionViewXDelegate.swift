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
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let selectedModel = self.skGetModelAtIndexPath(indexPath: indexPath)
        selectedModel.cellSelected()
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        guard !self.endHasNoItemLeft else { return }
        guard let endReachedModel = self.endReachedModel else { return }
        
        let isLoadingInProgress = self.collectionDatas.last?.models.contains(where: { $0 === endReachedModel }) ?? false
        guard !isLoadingInProgress else { return }
        
        let lastIndexSection = self.collectionDatas.count
        guard let lastIndexRow = self.collectionDatas.last?.models.count else { return }
        
        let isScrollExists = { () -> Bool in
            if self.isScrollingVertically() {
                return self.contentSize.height >= self.frame.size.height
            }else {
                return self.contentSize.width >= self.frame.size.width
            }
        }()
        
        guard isScrollExists else { return }
        
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
                self.skInsertModelAtTail(model: endReachedModel, scrollToIt: true)
                self.endReachedBlock?()
            })
        }
    }
    
    func prepareEndReachedModel() -> SKEndlessCModel
    {
        let indicatorHeight: CGFloat = 44
        let heightPadding: CGFloat = 40
        let cellHeight = indicatorHeight + heightPadding
        let cellWidth = self.isScrollingVertically() ? UIScreen.main.bounds.size.width : indicatorHeight
        
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        
        let endReachedModel = SKEndlessCModel(loadingSize: cellSize)
        endReachedModel.isInsideFramework = true
        return endReachedModel
    }

    public func skEndReached(endReachedBlock: @escaping (() -> Void))
    {
        let modelForEndReached = self.prepareEndReachedModel()
        self.skEndReached(model: modelForEndReached, endReachedBlock: endReachedBlock)
    }
    
    public func skEndReached(model: SKCollectionModel, endReachedBlock: @escaping (() -> Void))
    {
        self.endReachedModel = model
        self.endReachedBlock = endReachedBlock
    }
    
    public func skEndlessExecutionFinished(isNoMoreItemExists: Bool? = false)
    {
        self.endHasNoItemLeft = isNoMoreItemExists ?? false
        if let endReachedModel = self.endReachedModel
        {
            self.removeModel(modelToRemove: endReachedModel)
        }
    }
    
    func isScrollingHorizontally() -> Bool
    {
        return self.skGetLayout().scrollDirection == .horizontal
    }
    
    func isScrollingVertically() -> Bool
    {
        return self.skGetLayout().scrollDirection == .vertical
    }
}
