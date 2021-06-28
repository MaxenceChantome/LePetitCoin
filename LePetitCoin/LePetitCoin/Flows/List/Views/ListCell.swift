//
//  ListCell.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit


struct ListCellViewData {
    let id: Int
    let name: String
    let price: String
    let category: String
    let date: String
    let isUrgent: Bool
    let imageUrl: URL?
}

class ListCell: UITableViewCell {
    private let containerView = ContainerView()
    private let nameLabel = UILabel(title: nil, font: .title, color: .regularText, lines: 2, alignment: .left)
    private let priceLabel = UILabel(title: nil, font: .large, color: .regularText, lines: 1, alignment: .right)
    private let smallImageView = UIImageView(contentMode: .scaleAspectFill)
    private let dateLabel =  UILabel(title: nil, font: .bodyMedium, color: .lightGray, lines: 1, alignment: .center)
    private let categoryLabelView = LabelView(fillColor: .primary)
    private var urgentLabelView = LabelView(fillColor: .urgent, "Urgent")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .background
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let infoStackView = UIStackView(withDirection: .vertical, distribution: .fill, alignment: .leading, spacing: 2)
        let labelStackView = UIStackView(withDirection: .horizontal, distribution: .fill, alignment: .leading, spacing: 8)
        
        urgentLabelView.isHidden = true
        
        infoStackView.addArrangedSubviews([nameLabel, dateLabel])
        labelStackView.addArrangedSubviews([categoryLabelView, urgentLabelView])
        contentView.addSubview(containerView)
        containerView.addSubviews([smallImageView, infoStackView, labelStackView, priceLabel])
        
        let containerInset = UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16)
        containerView.bindConstraintsToSuperview(containerInset)
        
        smallImageView.cornerRadius = 8
        smallImageView.bindConstraints([
            smallImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            smallImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            smallImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            smallImageView.widthAnchor.constraint(equalToConstant: 100),
            smallImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        infoStackView.bindConstraints([
            infoStackView.topAnchor.constraint(equalTo: smallImageView.topAnchor),
            infoStackView.leftAnchor.constraint(equalTo: smallImageView.rightAnchor, constant: 8),
            infoStackView.rightAnchor.constraint(lessThanOrEqualTo: priceLabel.leftAnchor, constant: -8)
        ])
        labelStackView.bindConstraints([
            labelStackView.bottomAnchor.constraint(equalTo: smallImageView.bottomAnchor),
            labelStackView.leftAnchor.constraint(equalTo: smallImageView.rightAnchor, constant: 8)
        ])
        
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.5
        priceLabel.bindConstraints([
            priceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            priceLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16)
        ])
    }
    
    func configure(with viewData: ListCellViewData) {
        nameLabel.text = viewData.name
        priceLabel.text = viewData.price
        dateLabel.text = viewData.date
        categoryLabelView.configure(with: viewData.category)
        urgentLabelView.isHidden = !viewData.isUrgent
        smallImageView.image = nil
        if let imageUrl = viewData.imageUrl {
            smallImageView.load(url: imageUrl)
        }
    }
}
