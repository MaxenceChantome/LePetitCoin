//
//  CategoryCell.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

struct CategoryCellViewData {
    let name: String
}

protocol CategoryCellType {
    var onSelect: ((_ isSelected: Bool) -> Void)? { get set }
}

class CategoryCell: UITableViewCell {
    var onSelect: ((_ isSelected: Bool) -> Void)?
    
    private let categoryLabel = UILabel(title: nil, font: .bodyMedium, color: .regularText, lines: 0, alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(categoryLabel)
        
        let labelInset = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
        categoryLabel.bindConstraintsToSuperview(labelInset)
    }
    
    func configure(with viewData: CategoryCellViewData) {
        categoryLabel.text = viewData.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        backgroundColor = isSelected ? .primaryLight : .white
        onSelect?(selected)
    }
}
