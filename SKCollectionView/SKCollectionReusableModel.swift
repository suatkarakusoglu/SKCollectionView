//
//  SKCollectionReusableModel.swift
//  SKCollection
//
//  Created by Suat Karakusoglu on 1/29/17.
//  Copyright © 2017 sk. All rights reserved.
//
import UIKit

open class SKCollectionReusableModel
{
    open weak var boundView: SKCollectionReusableView?
    
    open var selectionBlock: (()->Void)?
    open var viewSelectedGestureRecognizer: UITapGestureRecognizer?
    
    public init() {}
    
    open func viewSize() -> CGSize
    {
        fatalError("View size have to be implemented.")
    }
    
    open func viewType() -> SKCollectionReusableView.Type
    {
        fatalError("View type have to be implemented")
    }
    
    open func onViewSelected(selectionBlock: @escaping (()->Void))
    {
        self.selectionBlock = selectionBlock
    }
    
    open func refreshBoundView()
    {
        self.boundView?.applyReusableModel(self)
    }
}

extension SKCollectionReusableModel
{
    func viewTypeIdentifier() -> String
    {
        let viewTypeName = NSStringFromClass(self.viewType())
        return viewTypeName.components(separatedBy: ".").last!
    }
}
