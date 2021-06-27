//
//  EmptyStateVIew.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

protocol EmptyStateViewType {
    var onRetry: (() -> Void)? { get set }
    func setTitle(_ title: String)
}

class EmptyStateView: UIView, EmptyStateViewType {
    var onRetry: (() -> Void)?
    
    private let titleLabel = UILabel(title: nil, font: .title, color: .regularText, lines: 0, alignment: .center)
    private let retryButton = UIButton(title: "Réessayer", font: .bodySemiBold, textColor: .white, backgroundColor: .primary)
    
    
    init() {
        super.init(frame: .zero)
        
        retryButton.addTarget(self, action: #selector(retryPushed), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([titleLabel, retryButton])
        
        titleLabel.bindConstraints([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        retryButton.cornerRadius = 25
        retryButton.bindConstraints([
            retryButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            retryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    @objc private func retryPushed() {
        onRetry?()
    }
}
