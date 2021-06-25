//
//  Date.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 25/06/2021.
//

import Foundation

enum DateFormat: String {
    case hourAndMinutes = "HH:mm"
    case dayAndMonth = "dd/MM"
}

extension Date {
    func string(withFormat format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.string(from: self)
    }
}
