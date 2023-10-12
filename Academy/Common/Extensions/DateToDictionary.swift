//
//  DateToDictionary.swift
//  Academy
//
//  Created by Konstantin Chukhas on 28.11.2021.
//

import Foundation

extension Date {
    static func dateDictionary(from arrayOfDates: [Date]) -> [String: [Date]] {
        return Dictionary(grouping: arrayOfDates) { date -> String in
            let dateFoormatter = DateFormatter()
            dateFoormatter.locale = Locale(identifier: "uk_UA")
            dateFoormatter.dateFormat = "LLLL"
            let monthName = dateFoormatter.string(from: date)
            return monthName
        }
    }
}
