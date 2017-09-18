//
//  SKCollectionViewXEndless.swift
//  SKCollectionView
//
//  Created by suat.karakusoglu on 19.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension SKCollectionView
{
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
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        guard let endReachedModel = self.endReachedModel else { return }
        
        let scrollViewYOffset = scrollView.contentOffset.y
        let contentSizeHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        let isScrollReachedEnd = scrollViewYOffset == (contentSizeHeight - scrollViewHeight)
        if isScrollReachedEnd
        {
            let isEndOfScrollModelAlreadyAdded = self.collectionDatas.last?.models.contains{ $0 === endReachedModel }
            let isThereNoEndOfScrollModel = !(isEndOfScrollModelAlreadyAdded ?? false)
            if  isThereNoEndOfScrollModel
            {
                self.skInsertModelAtTail(model: endReachedModel, scrollToIt: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                    self.endReachedBlock?()
                })
            }
        }
    }
}
