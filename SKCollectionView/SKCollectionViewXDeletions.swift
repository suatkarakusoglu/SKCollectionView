//
//  SKCollectionViewXDeletions.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/15/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import Foundation

extension SKCollectionView
{
    public func removeModel(modelToRemove: SKCollectionModel)
    {
        guard let indexPathToRemove = self.skGetIndexPathOfModel(collectionModelToFindIndex: modelToRemove) else { return }
        self.collectionDatas[indexPathToRemove.section].models.remove(at: indexPathToRemove.row)
        let indexPathsToRemove = [indexPathToRemove]
        self.deleteItems(at: indexPathsToRemove)
        self.handleEmptyData()
    }
}
