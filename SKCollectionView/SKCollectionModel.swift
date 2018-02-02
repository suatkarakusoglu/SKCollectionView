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
    open weak var ownerSKCollectionView: SKCollectionView?
    open weak var boundCollectionCell: SKCollectionCell?
    open var selectionBlock: (()->Void)?
    
    // This is used for xib loading from bundle.
    var isInsideFramework: Bool? = false

    public init()
    {
    }
    
    final func xibTypeIdentifier() -> String
    {
        let cellTypeName = NSStringFromClass(self.cellType())
        return cellTypeName.components(separatedBy: ".").last!
    }

    open func onCellSelected(selectionBlock: @escaping (()->Void))
    {
        self.selectionBlock = selectionBlock
    }
    
    func cellSelected()
    {
        self.selectionBlock?()
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

