//
//  SKCollectionViewXInsertions.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/15/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import Foundation

extension SKCollectionView
{
    public func skInsertModel(
        at sectionDataId: String,
        modelToInsert: SKCollectionModel,
        blockSortBy: ((_ model1: SKCollectionModel, _ model2: SKCollectionModel) -> Bool),
        scrollToIt: Bool = true )
    {
        self.skRegisterCellFor(modelToRegister: modelToInsert)
        let dataSection = { () -> Int? in
            var dataSectionIndex: Int? = nil
            self.collectionDatas.enumerated().forEach { (index: Int, collectionData: SKCollectionData) in
                if sectionDataId == collectionData.dataIdentifier {
                    dataSectionIndex = index
                }
            }
            return dataSectionIndex
        }()
        
        guard let dataSectionIndex = dataSection else { return }
        
        let dataRow = { () -> Int? in
            var dataRowIndex: Int? = nil
            self.collectionDatas[dataSectionIndex].models.enumerated().forEach { (index: Int, collectionModel: SKCollectionModel) in
                let sortedResult = blockSortBy(modelToInsert, collectionModel)
                if sortedResult{
                    dataRowIndex = index
                }
            }
            return dataRowIndex
        }()
        
        let insertRowIndex = { () -> Int in
            guard let dataRowIndex = dataRow else { return 0 }
            return dataRowIndex + 1
        }()
        
        self.collectionDatas[dataSectionIndex].models.insert(modelToInsert, at: insertRowIndex)
        let indexPathToInsert = IndexPath(row: insertRowIndex, section: dataSectionIndex)
        self.insertItems(at: [indexPathToInsert])
        self.skScrollToItem(at: indexPathToInsert)
    }
    
    public func skInsertModel(model: SKCollectionModel, indexPath: IndexPath, scrollToIt: Bool = false)
    {
        self.skRegisterCellFor(modelToRegister: model)
        self.collectionDatas[indexPath.section].models.insert(model, at: indexPath.row)
        self.insertItems(at: [indexPath])
        
        if scrollToIt
        {
            self.skScrollToItem(at: indexPath)
        }
    }
    
    public func skInsertModel(model: SKCollectionModel, afterModel: SKCollectionModel, scrollToIt: Bool = false)
    {
        guard let indexPathOfModel = self.skGetIndexPathOfModel(collectionModelToFindIndex: afterModel) else { return }
        let rowToInsert = indexPathOfModel.row + 1
        let indexPathToInsert = IndexPath(row: rowToInsert, section: indexPathOfModel.section)
        self.skInsertModel(model: model, indexPath: indexPathToInsert, scrollToIt: scrollToIt)
    }
    
    public func skInsertCollectionData(collectionData: SKCollectionData, at index: Int?)
    {
        let indexToInsert = index ?? self.collectionDatas.count
        self.collectionDatas.insert(collectionData, at: indexToInsert)
        self.skRegisterCollectionData(collectionDataToRegister: collectionData)
        self.reloadData()
    }
    
    public func skInsertModelAtTail(model: SKCollectionModel, scrollToIt: Bool = false)
    {
        if let emptyModel = self.collectionDatas.first?.models.first as? SKCollectionEmptyCaseCModel
        {
            self.collectionDatas[0].models.remove(at: 0)
            self.deleteItems(at: [IndexPath(row:0, section: 0)])
        }
        
        self.skRegisterCellFor(modelToRegister: model)
        let lastSectionIndex = self.collectionDatas.count - 1
        self.collectionDatas[lastSectionIndex].models.append(model)
        let lastIndexPath = IndexPath(row: self.collectionDatas[lastSectionIndex].models.count - 1, section: lastSectionIndex)
        self.insertItems(at: [lastIndexPath])
        
        if scrollToIt {
            self.skScrollToItem(at: lastIndexPath)
        }
    }
    
    public func skInsertModelsAtTail(models: [SKCollectionModel], scrollToIt: Bool = false)
    {
        models.forEach{ self.skInsertModelAtTail(model: $0, scrollToIt: scrollToIt) }
    }
}
