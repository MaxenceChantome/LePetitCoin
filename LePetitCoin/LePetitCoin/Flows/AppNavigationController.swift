//
//  AppNavigationController.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation
import UIKit

class AppNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        setupBarUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBarUI() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .blue
        
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = attributes
        }

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = navigationBar.barTintColor
            appearance.titleTextAttributes = attributes
            appearance.largeTitleTextAttributes = attributes
            
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
