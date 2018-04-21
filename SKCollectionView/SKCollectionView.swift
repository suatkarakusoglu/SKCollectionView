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
        self.initialize()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        self.initialize()
    }
    
    private func initialize()
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
        
        let isDataEmpty = self.collectionDatas.first?.models.isEmpty ?? true
        
        if isDataEmpty
        {
            if let emptyCaseData = self.prepareEmptyCaseCollectionData(currentDatas: fullCollectionDatas)
            {
                self.collectionDatas = [emptyCaseData]
                self.collectionDatas.forEach { self.skRegisterCollectionData(collectionDataToRegister: $0) }
            }
        }else
        {
            self.collectionDatas.forEach { self.skRegisterCollectionData(collectionDataToRegister: $0) }
        }
        
        self.reloadData()
    }
    
    func prepareEmptyCaseCollectionData(currentDatas: [SKCollectionData]) -> SKCollectionData?
    {
        let isEmptyCaseExists = self.emptyCaseInfo != nil
        guard isEmptyCaseExists else { return nil }
        
        let emptyCaseInfo = self.emptyCaseInfo!
        
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
        var indexPath: IndexPath? = nil
        
        self.collectionDatas.enumerated().forEach { (indexSection: Int, collectionData: SKCollectionData) in
            collectionData.models.enumerated().forEach({ (indexRow:Int, collectionModel: SKCollectionModel) in
                if collectionModelToFindIndex === collectionModel {
                    indexPath = IndexPath(row: indexRow, section: indexSection)
                }
            })
        }
        return indexPath
    }
    
    public func skGetLayout() -> UICollectionViewFlowLayout
    {
        return self.collectionViewLayout as! UICollectionViewFlowLayout
    }

    func skScrollToItem(at indexPath: IndexPath, scrollPosition: UICollectionViewScrollPosition? = nil)
    {
        let defaultScrollPosition: UICollectionViewScrollPosition = self.skGetLayout().scrollDirection == .vertical ? .bottom : .right
        let positionToScroll = scrollPosition ?? defaultScrollPosition
        self.scrollToItem(at: indexPath, at: positionToScroll, animated: true)
    }
}
