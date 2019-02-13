//
//  SKCollectionReusableView.swift
//  SKCollection
//
//  Created by Suat Karakusoglu on 1/29/17.
//  Copyright © 2017 sk. All rights reserved.
//

import UIKit

open class SKCollectionReusableView: UICollectionReusableView
{
    var reusableModel: SKCollectionReusableModel?
    
    open func applyReusableModel(_ model: SKCollectionReusableModel)
    {
        self.reusableModel = model
        
        let isViewSelectable = model.selectionBlock != nil
        let isSelectableGestureNotAdded = model.viewSelectedGestureRecognizer == nil
        let shouldAddTapGesture = isViewSelectable && isSelectableGestureNotAdded
        
        if shouldAddTapGesture
        {
            guard model.viewSelectedGestureRecognizer == nil else { return }
            
            let viewTapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(SKCollectionReusableView.viewSelected(sender:))
            )
            
            self.addGestureRecognizer(viewTapGesture)
        }
    }
    
    @objc open func viewSelected(sender: UITapGestureRecognizer)
    {
        self.getReusableModel().selectionBlock?()
    }
    
    open func getReusableModel<T: SKCollectionReusableModel>() -> T
    {
        return self.reusableModel as! T
    }
}
