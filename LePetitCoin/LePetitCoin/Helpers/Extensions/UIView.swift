//
//  UIView.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation
import UIKit

extension UIView {
    var cornerRadius: CGFloat? {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue ?? 0
            layer.masksToBounds = (newValue ?? CGFloat(0.0)) > CGFloat(0.0)
        }
    }
    
    func bindConstraints(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func bindConstraintsToSuperview(_ inset: UIEdgeInsets? = nil) {
        guard let superview = superview else {
            fatalError("Superview not found, try superview.addSubview(view) first")
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset?.top ?? 0),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: inset?.bottom ?? 0),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: inset?.left ?? 0),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: inset?.right ?? 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
