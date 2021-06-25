//
//  Ads.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

typealias Ads = [Ad]

// MARK: - Ad
struct Ad: Codable {
    let id, categoryID: Int
    let title, adDescription: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case adDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
    
    // MARK: - ImagesURL
    struct ImagesURL: Codable {
        let small, thumb: String?
    }
}
