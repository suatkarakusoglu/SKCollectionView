//
//  SKCollectionViewXMoves.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 16.12.2018.
//  Copyright © 2018 suat.karakusoglu. All rights reserved.
//

import Foundation

extension SKCollectionView
{
    public func skMoveModel(_ modelToMove: SKCollectionModel, to newIndexPath: IndexPath)
    {
        guard let indexPathOfModel = self.skGetIndexPathOfModel(collectionModelToFindIndex: modelToMove) else { return }
        let movingModel = self.collectionDatas[indexPathOfModel.section].models.remove(at: indexPathOfModel.row)
        self.collectionDatas[newIndexPath.section].models.insert(movingModel, at: newIndexPath.row)
        
        self.moveItem(at: indexPathOfModel, to: newIndexPath)
    }
}
