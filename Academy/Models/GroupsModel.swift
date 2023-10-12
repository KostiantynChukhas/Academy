//
//  GroupsModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 23.11.2021.
//

import Foundation

// MARK: - Group
struct GroupsModel: Decodable {
    let id, name: String?
    let category, picture: String?
    let pictureUrl: String?
    let schedules: [Schedule?]
    let groupPublic: Bool?
    let archive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, category, picture
        case pictureUrl
        case schedules
        case groupPublic = "public"
        case archive
    }
}
// MARK: - Schedule
struct Schedule: Decodable {
    let location: String?
    let trainers: [String?]
}

