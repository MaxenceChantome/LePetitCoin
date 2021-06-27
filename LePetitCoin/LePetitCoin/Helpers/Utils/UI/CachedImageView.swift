//
//  CachedImageView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

fileprivate let ImageCache = NSCache<NSString, UIImage>()

class CachedImageView: UIImageView {
    init(contentMode mode: UIView.ContentMode) {
        super.init(image: nil)
        self.setPlaceholder()
        self.contentMode = mode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(url: URL) {
        let cacheKey = NSString(string: url.absoluteString)
        
        if let cachedImage = ImageCache.object(forKey: cacheKey) {
            image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCache.setObject(image, forKey: cacheKey)
                        self?.image = image
                    }
                } else {
                    self?.setPlaceholder()
                }
            } else {
                self?.setPlaceholder()
            }
        }
    }
    
    func setPlaceholder() {
        DispatchQueue.main.async {
            self.image = #imageLiteral(resourceName: "placeholder")
        }
    }
}
