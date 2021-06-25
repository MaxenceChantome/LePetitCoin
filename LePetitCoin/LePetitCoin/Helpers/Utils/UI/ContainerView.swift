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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
