//
//  UILabel.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(title: String? = nil, font: UIFont, color: UIColor, lines: Int = 1, alignment: NSTextAlignment? = nil) {
        self.init()
        self.text = title
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        self.font = font
        self.textColor = color
        self.numberOfLines = lines
    }
}
