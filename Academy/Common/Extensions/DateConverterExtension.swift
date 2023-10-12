//
//  DateConverterExtension.swift
//  Academy
//
//  Created by Konstantin Chukhas on 26.11.2021.
//

import Foundation
extension String {

    func toDate(with format: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "uk-UA")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func convertISOToString(convertTo: String) -> String {
        let dateFormatter = DateFormatter()

        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]

        if let realDate = isoDateFormatter.date(from: self) {
            dateFormatter.dateFormat = convertTo
            return dateFormatter.string(from: realDate)
        }else {
            return ""
        }
    }
    
    func convertISOToDate() -> Date {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]

        if let realDate = isoDateFormatter.date(from: self) {
            return realDate
        }else {
            return Date()
        }
    }
    
}

extension Date {

    func toString(with format: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "uk-UA")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
