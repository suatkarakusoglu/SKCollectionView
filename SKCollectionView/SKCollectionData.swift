//
//  SKCollectionData.swift
//  SKCollection
//
//  Created by Suat Karakusoglu on 1/29/17.
//  Copyright © 2017 sk. All rights reserved.
//

open class SKCollectionData
{
    open var dataIdentifier: String? 
    open var headerModel: SKCollectionReusableModel?
    open var footerModel: SKCollectionReusableModel?
    open var models: [SKCollectionModel] = []
    
    public init(models: [SKCollectionModel],
         headerModel: SKCollectionReusableModel? = nil,
         footerModel: SKCollectionReusableModel? = nil
        )
    {
        self.models = models
        self.headerModel = headerModel
        self.footerModel = footerModel
    }
}
