//
//  SKollectionView.swift
//  SKollection
//
//  Created by Suat Karakusoglu on 1/28/17.
//  Copyright © 2017 sk. All rights reserved.
//

import UIKit

open class SKCollectionView: UICollectionView
{
    public var emptyCaseInfo: SKEmptyCaseInfo?
    open var blockPullToRefresh: (() -> Void)?
    
    public var refreshControlForLowerThaniOS10: UIRefreshControl?
    
    public var collectionDatas: [SKCollectionData] = [SKCollectionData]()
    var alreadyRegisteredCells: [String] = []
    
    public var endReachedModel: SKCollectionModel?
    public var endReachedBlock: (() -> Void)?
    public var endHasNoItemLeft: Bool = false
    
    public var blockScrollViewDidScroll: (() -> Void)?
    public var blockScrollViewDidEndDecelerating: (() -> Void)?
    public var blockOnPageChanged: ((_ page: Int) -> Void)?

    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.skInitialize()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        self.skInitialize()
    }
    
    private func skInitialize()
    {
        self.delegate = self
        self.dataSource = self
        let layout = self.skGetLayout()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        if #available(iOS 9.0, *) {
            layout.sectionFootersPinToVisibleBounds = true
            layout.sectionHeadersPinToVisibleBounds = true
        } else {
            debugPrint("Can not pin the header-footer views under iOS 9.")
        }
        
        self.skRegisterCellFor(identifer: "SKCollectionEmptyCaseCCell", isInsideFramework: true)
    }

    public func skSetCollectionDatas(_ collectionDatas: [SKCollectionData?])
    {
        let fullCollectionDatas = collectionDatas.compactMap{ $0 }
        self.collectionDatas = fullCollectionDatas
        
        self.handleEmptyData()
        self.collectionDatas.forEach { self.skRegisterCollectionData(collectionDataToRegister: $0) }
        self.reloadData()
    }
    
    func skPrepareEmptyCaseCollectionData(currentDatas: [SKCollectionData]) -> SKCollectionData?
    {
        guard let emptyCaseInfo = self.emptyCaseInfo else { return nil }
                
        let emptyModelHeight: CGFloat = 320
        
        let emptyCollectionModel = SKCollectionEmptyCaseCModel(
            imageIcon: emptyCaseInfo.image,
            title: emptyCaseInfo.title,
            subTitle: emptyCaseInfo.subTitle,
            height: emptyModelHeight,
            buttonInfo: emptyCaseInfo.buttonInfo
        )
        
        emptyCollectionModel.isInsideFramework = true
        
        let emptyCollectionData = SKCollectionData(
            models: [emptyCollectionModel],
            headerModel: currentDatas.first?.headerModel,
            footerModel: currentDatas.first?.footerModel
        )
        
        return emptyCollectionData
    }
    
    func handleEmptyData()
    {
        let isDataEmpty = self.collectionDatas.first?.models.isEmpty ?? true
        guard isDataEmpty else { return }
        guard let emptyData = self.skPrepareEmptyCaseCollectionData(currentDatas: self.collectionDatas) else { return }
        
        self.collectionDatas = [emptyData]
        self.reloadData()
    }

    public func skGetModelAtIndexPath(indexPath: IndexPath) -> SKCollectionModel
    {
        return self.collectionDatas[indexPath.section].models[indexPath.row]
    }
    
    public func skGetCollectionData(by id: String) -> SKCollectionData?
    {
        return self.collectionDatas.skFindFirst{ $0.dataIdentifier == id }
    }
    
    public func skScrollToModel(model: SKCollectionModel, scrollPosition: UICollectionViewScrollPosition? = nil)
    {
        guard let indexPathForModelToScroll = self.skGetIndexPathOfModel(collectionModelToFindIndex: model) else { return }
        self.skScrollToItem(at: indexPathForModelToScroll, scrollPosition: scrollPosition)
    }

    public func skReloadModel(model: SKCollectionModel)
    {
        guard let indexPathForModel = self.skGetIndexPathOfModel(collectionModelToFindIndex: model) else { return }
        self.reloadItems(at: [indexPathForModel])
    }
    
    func skGetIndexPathOfModel(collectionModelToFindIndex: SKCollectionModel) -> IndexPath?
    {
        for (indexSection, collectionData) in self.collectionDatas.enumerated()
        {
            for (indexRow, collectionModel) in collectionData.models.enumerated()
            {
                if collectionModelToFindIndex === collectionModel {
                    let indexPathOfModel = IndexPath(row: indexRow, section: indexSection)
                    return indexPathOfModel
                }
            }
        }
        
        return nil
    }
    
    public func skGetLayout() -> UICollectionViewFlowLayout
    {
        return self.collectionViewLayout as! UICollectionViewFlowLayout
    }

    func skScrollToItem(at indexPath: IndexPath, scrollPosition: UICollectionViewScrollPosition? = nil)
    {
        let isLayoutVertical = self.skGetLayout().scrollDirection == .vertical
        let defaultScrollPosition: UICollectionViewScrollPosition = isLayoutVertical ? .bottom : .right
        let positionToScroll = scrollPosition ?? defaultScrollPosition
        self.scrollToItem(at: indexPath, at: positionToScroll, animated: true)
    }
    
    public func skScrollToTop(animated: Bool = true)
    {
        self.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    public func skChangeContentInset(top: Int? = nil, left: Int? = nil, bottom: Int? = nil, right: Int? = nil)
    {
        let topNew = top ?? Int(self.contentInset.top)
        let leftNew = left ?? Int(self.contentInset.left)
        let bottomNew = bottom ?? Int(self.contentInset.bottom)
        let rightNew = right ?? Int(self.contentInset.right)
        
        self.contentInset = UIEdgeInsets(
            top: CGFloat(topNew),
            left: CGFloat(leftNew),
            bottom: CGFloat(bottomNew),
            right: CGFloat(rightNew)
        )
    }
}
