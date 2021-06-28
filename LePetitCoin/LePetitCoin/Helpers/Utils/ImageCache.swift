//
//  ImageCache.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation
import UIKit

protocol ImageCacheType {
    func save(for key: String, image: UIImage)
    func get(from key: String) -> UIImage?
}

class ImageCache: ImageCacheType {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func save(for key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(from key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
