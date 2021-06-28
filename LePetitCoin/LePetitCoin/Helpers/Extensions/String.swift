//
//  String.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation

extension String {
    func iso8601Date() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+0000"
        return formatter.date(from: self)
    }
}
