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
    open var shouldBindToView: Bool = false
    open var boundView: SKCollectionReusableView?
    
    public init() {}
    
    open func viewSize() -> CGSize
    {
        fatalError("View size have to be implemented.")
    }
    
    open func viewType() -> SKCollectionReusableView.Type
    {
        fatalError("View type have to be implemented")
    }
    
    open func viewSelected() {
        
    }
    
    open func refreshBoundView()
    {
        self.boundView?.applyReusableModel(reusableModel: self)
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
