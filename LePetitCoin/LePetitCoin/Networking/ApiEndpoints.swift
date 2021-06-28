//
//  ApiEndpoints.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

public enum ApiEndpoints {
    case list
    case categories
}

extension ApiEndpoints {
    var path: String {
        switch self {
        case .categories:
            return "/leboncoin/paperclip/master/categories.json"
        case .list:
            return "/leboncoin/paperclip/master/listing.json"
        }
    }
    
    var mockFilename: String {
        switch self {
        case .categories:
            return "MockCategories"
        case .list:
            return "MockList"
        }
    }
}
