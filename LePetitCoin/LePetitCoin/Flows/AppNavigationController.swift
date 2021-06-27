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
        navigationBar.barTintColor = .primary
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
    }
}
