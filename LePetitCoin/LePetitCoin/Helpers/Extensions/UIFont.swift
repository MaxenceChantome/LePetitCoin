//
//  UIFont.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

extension UIFont {
    
    class var large: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    class var title: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    class var bodyMedium: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    class var bodySemiBold: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
}
