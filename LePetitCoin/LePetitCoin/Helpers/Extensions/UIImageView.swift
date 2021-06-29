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
    
    /// URLSessionDataTask can be canceled for better performances
    func load(url: URL) -> URLSessionDataTask? {
        if let cachedImage = ImageCache.shared.get(from: url.absoluteString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return nil
        }
        setPlaceholder()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageCache.shared.save(for: url.absoluteString, image: image)
                    self.image = image
                }
            } else {
                self.setPlaceholder()
            }
        }
        task.resume()
        return task
    }
    
    func setPlaceholder() {
        DispatchQueue.main.async {
            self.image = #imageLiteral(resourceName: "placeholder")
        }
    }
}
