//
//  SKCollectionViewXDelegate.swift
//  Zamekan
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension SKCollectionView: UICollectionViewDelegate
{
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedModel = self.skGetModelAtIndexPath(indexPath: indexPath)
        selectedModel.cellSelected()
    }
}
