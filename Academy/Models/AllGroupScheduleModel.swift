//
//  AllGroupScheduleModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 28.11.2021.
//

import Foundation

// MARK: - AllGroupScheduleModel

struct AllGroupScheduleModel: Codable {
    let id, location, group, groupName: String?
    let professionals, professionalsNames: [String]?
    let category: String?

    enum CodingKeys: String, CodingKey {
        case id, location, group
        case groupName
        case professionals
        case professionalsNames
        case category
    }
}
