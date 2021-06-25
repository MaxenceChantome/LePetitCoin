//
//  UIColor.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

extension UIColor {
    class var background: UIColor {
        return UIColor(red: 235 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
    }
    
    class var regularText: UIColor {
        return UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1)
    }
    
    class var lightText: UIColor {
        return UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 1)
    }
    
    class var urgent: UIColor {
        return UIColor(red: 255 / 255, green: 93 / 255, blue: 143 / 255, alpha: 1)
    }
    
    class var primary: UIColor {
        return UIColor(red: 147 / 255, green: 129 / 255, blue: 255 / 255, alpha: 1)
    }
}
