//
//  SKCollectionViewFlowLayout.swift
//  SKCollectionView
//
//  Created by suat.karakusoglu on 13.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import Foundation
// TODO: Get animations from SKCollectionView constructor
class SKCollectionViewFlowLayout: UICollectionViewFlowLayout
{
    var indexPathsToInsert = [IndexPath]()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init()
    {
        super.init()
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        
        if #available(iOS 9.0, *) {
            self.sectionFootersPinToVisibleBounds = true
            self.sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
    }

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem])
    {
        super.prepare(forCollectionViewUpdates: updateItems)
        self.indexPathsToInsert.removeAll()
        
        for update in updateItems{
            if let indexPath = update.indexPathAfterUpdate {
                switch update.updateAction{
                case .insert:
                    self.indexPathsToInsert.append(indexPath)
                case .delete: break
                case .reload: break
                case .move: break
                case .none: break
                }
            }
        }
    }
    
    override func finalizeCollectionViewUpdates()
    {
        super.finalizeCollectionViewUpdates()
        self.indexPathsToInsert.removeAll()
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        guard let layoutAttributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else { return nil }
        
        if self.indexPathsToInsert.contains(itemIndexPath)
        {
            return self.insertModification(layoutAttributes: layoutAttributes)
        }

        return layoutAttributes
    }

    private func insertModification(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
    {
        layoutAttributes.transform = CGAffineTransform(translationX: 0, y: 500.0 )
        return layoutAttributes
    }
}
