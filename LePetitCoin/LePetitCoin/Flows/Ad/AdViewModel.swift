//
//  AdViewModel.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation

protocol AdViewModelType {
    init(ad: Ad, category: String)
    
    var imageViewData: AdImageCellViewData { get }
    var infosViewData: AdInfosCellViewData { get }
    var description: String { get }
}

class AdViewModel: AdViewModelType {
    private let ad: Ad
    private let category: String
    
    required init(ad: Ad, category: String) {
        self.ad = ad
        self.category = category
    }
    
    var imageViewData: AdImageCellViewData {
        let url = ad.imagesURL.thumb != nil ? URL(string: ad.imagesURL.thumb!) : nil
        return AdImageCellViewData(imageUrl: url, isUrgent: ad.isUrgent)
    }
    
    var infosViewData: AdInfosCellViewData {
        let date = "Posté le \(ad.creationDate.string(withFormat: .dayAndMonth)) à \(ad.creationDate.string(withFormat: .hourAndMinutes))"
        let siret = ad.siret != nil ? "Siret: \(ad.siret ?? "")" : nil
        let viewData = AdInfosCellViewData(name: ad.title,
                                           date: date,
                                           price: "\(ad.price) €",
                                           category: category,
                                           siret: siret)
        return viewData
    }
    
    var description: String {
        return ad.adDescription
    }
}
