//
//  CategoryHeaderView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

protocol CategoryHeaderViewType {
    var onDismiss: (() -> Void)? { get set }
}

class CategoryHeaderView: UIView, CategoryHeaderViewType {
    var onDismiss: (() -> Void)?
    
    private let dismissButton = UIButton(title: "✖️", font: .bodyMedium, textColor: .regularText, backgroundColor: .white)
    private let titleLabel = UILabel(title: "Catégories", font: .title, color: .white, lines: 0, alignment: .left)
    
    init() {
        super.init(frame: .zero)
        
        dismissButton.addTarget(self, action: #selector(dismissPushed), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.accessibilityIdentifier = "titleLabel"
        dismissButton.accessibilityIdentifier = "dismissButton"
        backgroundColor = .primary
        addSubviews([titleLabel, dismissButton])
        
        titleLabel.bindConstraints([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
        let buttonHeight: CGFloat = 25.0
        dismissButton.cornerRadius = buttonHeight / 2
        dismissButton.bindConstraints([
            dismissButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            dismissButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            dismissButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            dismissButton.widthAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func dismissPushed() {
        onDismiss?()
    }
}
