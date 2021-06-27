//
//  AdInfosCell.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

struct AdInfosCellViewData {
    let name: String
    let date: String
    let price: String
    let category: String
    let siret: String?
}

class AdInfosCell: UITableViewCell {
    private let nameLabel = UILabel(title: nil, font: .title, color: .regularText, lines: 0, alignment: .left)
    private let categoryLabel = UILabel(title: nil, font: .bodyMedium, color: .primary, lines: 0, alignment: .left)
    private let priceLabel = UILabel(title: nil, font: .large, color: .regularText, lines: 0, alignment: .left)
    private let dateLabel =  UILabel(title: nil, font: .bodyMedium, color: .lightGray, lines: 0, alignment: .left)
    private lazy var siretLabel = UILabel(title: nil, font: .bodyMedium, color: .regularText, lines: 0, alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews([nameLabel, categoryLabel, dateLabel, siretLabel, priceLabel])
        
        nameLabel.bindConstraints([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        categoryLabel.bindConstraints([
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            categoryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            categoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        priceLabel.bindConstraints([
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        siretLabel.bindConstraints([
            siretLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            siretLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            siretLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        dateLabel.bindConstraints([
            dateLabel.topAnchor.constraint(equalTo: siretLabel.bottomAnchor, constant: 8),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with viewData: AdInfosCellViewData) {
        self.nameLabel.text = viewData.name
        self.categoryLabel.text = viewData.category
        self.priceLabel.text = viewData.price
        self.dateLabel.text = viewData.date
        if let siret = viewData.siret {
            siretLabel.text = siret
        }
    }
}
