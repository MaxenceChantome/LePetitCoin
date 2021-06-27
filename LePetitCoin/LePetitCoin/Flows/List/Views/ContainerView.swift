//
//  ContainerView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

class ContainerView: UIView {
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        cornerRadius = 8
        // set shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor.regularText.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
