//
//  SKCollectionViewXCellRegistration.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/15/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

extension SKCollectionView
{
    func skRegisterCellFor(identifer: String, isInsideFramework: Bool = false)
    {
        let isAlreadyRegistered = self.alreadyRegisteredCells.contains{ $0 == identifer }
        guard !isAlreadyRegistered else { return }
        
        let bundleToLoadFrom = isInsideFramework ? Bundle.skFrameworkBundle() : Bundle.main
        let nibCell = UINib(nibName: identifer, bundle: bundleToLoadFrom)
        self.register(nibCell, forCellWithReuseIdentifier: identifer)
        self.alreadyRegisteredCells.append(identifer)
    }
    
    func skRegisterCellFor(modelToRegister: SKCollectionModel)
    {
        let nibIdentifier = modelToRegister.xibTypeIdentifier()
        let isInsideFramework = modelToRegister.isInsideFramework ?? false
        self.skRegisterCellFor(identifer: nibIdentifier, isInsideFramework: isInsideFramework)
    }
    
    func skRegisterReusableModel(reusableModel: SKCollectionReusableModel?, viewKind: String)
    {
        guard let reusableModel = reusableModel else { return }
        let supplementaryNib = UINib(nibName: reusableModel.viewTypeIdentifier(), bundle: nil)
        self.register(
            supplementaryNib,
            forSupplementaryViewOfKind: viewKind,
            withReuseIdentifier: reusableModel.viewTypeIdentifier()
        )
    }
    
    func skRegisterCollectionData(collectionDataToRegister: SKCollectionData)
    {
        collectionDataToRegister.models.forEach { self.skRegisterCellFor(modelToRegister: $0) }
        
        self.skRegisterReusableModel(
            reusableModel: collectionDataToRegister.headerModel,
            viewKind: UICollectionElementKindSectionHeader
        )
        
        self.skRegisterReusableModel(
            reusableModel: collectionDataToRegister.footerModel,
            viewKind: UICollectionElementKindSectionFooter
        )
    }
}
