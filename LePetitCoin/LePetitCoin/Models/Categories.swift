//
//  Categories.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

typealias Categories = [Category]

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
}
