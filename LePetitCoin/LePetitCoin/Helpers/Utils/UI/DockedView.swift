//
//  DockedView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

protocol DockedViewType {
    var onSelect: (() -> Void)? { get set }
}

class DockedView: UIView, DockedViewType {
    var onSelect: (() -> Void)?
    
    private let dockedButton = UIButton(title: "", font: .title, textColor: .white, backgroundColor: .primary)
    private let separatorView = UIView(backgroundColor: .primary)
    
    init(title: String) {
        super.init(frame: .zero)
        
        dockedButton.setTitle(title, for: .normal)
        dockedButton.addTarget(self, action: #selector(buttonPushed), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([separatorView, dockedButton])
        
        separatorView.bindConstraints([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        let contactButtonInset = UIEdgeInsets(top: 16, left: 24, bottom: -16, right: -24)
        dockedButton.bindConstraintsToSuperview(contactButtonInset)
        dockedButton.cornerRadius = 25
        dockedButton.bindConstraints([
            dockedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func buttonPushed() {
        onSelect?()
    }
}
