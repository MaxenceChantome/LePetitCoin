//
//  UIImageView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(contentMode mode: UIView.ContentMode) {
        self.init(image: nil)
        self.setPlaceholder()
        self.contentMode = mode
    }
    
    func load(url: URL) {
        if let cachedImage = ImageCache.shared.get(from: url.absoluteString) {
            image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCache.shared.save(for: url.absoluteString, image: image)
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
