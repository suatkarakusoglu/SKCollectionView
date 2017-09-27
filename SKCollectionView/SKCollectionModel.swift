//
//  SKCollectionModel.swift
//  SKCollection
//
//  Created by Suat Karakusoglu on 1/29/17.
//  Copyright © 2017 sk. All rights reserved.
//

import Foundation

import UIKit

open class SKCollectionModel: SKCollectionModelProtocol
{
    open var ownerSKCollectionView: SKCollectionView?
    open var modelId: String?
    open var boundCollectionCell: SKCollectionCell?
    open var shouldBindToCell: Bool = false
    open var selectionBlock: (()->Void)?

    public init()
    {
    }
    
    open func bindToCell(withId: String = String.skRandomString(length: 16))
    {
        self.shouldBindToCell = true
        self.modelId = withId
    }
    
    final func xibTypeIdentifier() -> String
    {
        let cellTypeName = NSStringFromClass(self.cellType())
        return cellTypeName.components(separatedBy: ".").last!
    }
    
    final func cellTypeIdentifier() -> String
    {
        return self.xibTypeIdentifier() + (self.modelId ?? "")
    }
    
    open func onCellSelected(selectionBlock: @escaping (()->Void))
    {
        self.selectionBlock = selectionBlock
    }
    
    func cellSelected()
    {
        self.selectionBlock?()
    }
    
    open func refreshBoundCell()
    {
        self.boundCollectionCell?.applyModel(kollectionModel: self)
    }
    
    open func removeFromCollection()
    {
        self.ownerSKCollectionView?.removeModel(modelToRemove: self)
    }
    
    open func reloadModel()
    {
        self.ownerSKCollectionView?.skReloadModel(model: self)
    }
    
    open func cellSize() -> CGSize { fatalError("Cell size have to be implemented.") }
    open func cellType() -> SKCollectionCell.Type { fatalError("Cell type have to be implemented.")  }
}

