//
//  AdImageCell.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

struct AdImageCellViewData {
    let imageUrl: URL?
    let isUrgent: Bool
}

class AdImageCell: UITableViewCell {
    private let adImageView = UIImageView(contentMode: .scaleToFill)
    private var urgentLabelView = LabelView(fillColor: .urgent, "Urgent")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        urgentLabelView.isHidden = true
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        urgentLabelView.setLabelAccessiblityId("adUrgentLabel")
        contentView.addSubviews([adImageView, urgentLabelView])
        
        adImageView.clipsToBounds = true
        adImageView.bindConstraintsToSuperview()
        urgentLabelView.bindConstraints([
            urgentLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            urgentLabelView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
    
    func configure(with viewData: AdImageCellViewData) {
        if let url = viewData.imageUrl {
            adImageView.load(url: url)
        }
        urgentLabelView.isHidden = !viewData.isUrgent
    }
}
