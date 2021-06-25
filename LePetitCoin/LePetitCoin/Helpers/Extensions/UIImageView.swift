//
//  UIImageView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode mode: UIView.ContentMode) {
        self.init(image: image)
        self.contentMode = mode
    }
}
