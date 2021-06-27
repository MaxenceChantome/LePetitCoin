//
//  DockedView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

protocol ContactViewType {
    var onContact: (() -> Void)? { get set }
}

class ContactView: UIView, ContactViewType {
    var onContact: (() -> Void)?
    
    private let contactButton = UIButton(title: "Contacter", font: .title, textColor: .white, backgroundColor: .primary)
    private let separatorView = UIView(backgroundColor: .primary)
    
    init() {
        super.init(frame: .zero)
        
        contactButton.addTarget(self, action: #selector(contactPushed), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([separatorView, contactButton])
        
        separatorView.bindConstraints([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        let contactButtonInset = UIEdgeInsets(top: 16, left: 24, bottom: -16, right: -24)
        contactButton.bindConstraintsToSuperview(contactButtonInset)
        contactButton.cornerRadius = 25
        contactButton.bindConstraints([
            contactButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func contactPushed() {
        onContact?()
    }
}
