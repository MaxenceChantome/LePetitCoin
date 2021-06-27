//
//  AdDescriptionCell.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

class AdDescriptionCell: UITableViewCell {
    private let titleLabel = UILabel(title: "Description", font: .title, color: .regularText, lines: 0, alignment: .left)
    private let descriptionLabel = UILabel(title: nil, font: .bodyMedium, color: .regularText, lines: 0, alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews([titleLabel, descriptionLabel])
        
        titleLabel.bindConstraints([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        descriptionLabel.bindConstraints([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with description: String) {
        descriptionLabel.text = description
    }
}
