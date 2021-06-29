//
//  LabelView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

class LabelView: UIView {
    private let label = UILabel(title: nil, font: .bodyMedium, color: .white, lines: 1, alignment: .center)
    
    init(fillColor: UIColor, _ text: String? = nil) {
        super.init(frame: .zero)
        
        label.text = text
        backgroundColor = fillColor
        cornerRadius = 8
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(label)
        
        let labelInset = UIEdgeInsets(top: 4, left: 8, bottom: -4, right: -8)
        label.bindConstraintsToSuperview(labelInset)
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
    // Used for UITests
    func setLabelAccessiblityId(_ id: String) {
        label.accessibilityIdentifier = id
    }
}
