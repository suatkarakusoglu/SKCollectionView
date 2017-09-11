//
//  SKCollectionViewXDelegateFlowLayout.swift
//  Zamekan
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

// MARK: UICollectionViewDelegateFlowLayout
extension SKCollectionView: UICollectionViewDelegateFlowLayout
{
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = self.skGetModelAtIndexPath(indexPath: indexPath).cellSize()
        return cellSize
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let headerModel = self.collectionDatas[section].headerModel else { return CGSize.zero }
        return headerModel.viewSize()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let footerModel = self.collectionDatas[section].footerModel else { return CGSize.zero }
        return footerModel.viewSize()
    }
}
