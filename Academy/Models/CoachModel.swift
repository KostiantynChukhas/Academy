//
//  CoachModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 21.11.2021.
//

import Foundation

// MARK: - CoachModelElement
struct CoachModel: Decodable, Equatable {
    let id, name: String?
    let gender: String?
    let photoExists,archive: Bool?
    let positions, positionNames: [String]?
    let roles: [Role]?
    
    enum CodingKeys: String, CodingKey {
            case id, name, gender
            case photoExists
            case positions
            case positionNames
            case roles
            case archive
        }
}

enum Role: String, Codable {
    case administrator = "administrator"
    case owner = "owner"
    case professional = "professional"
    case technicalStaff = "technicalStaff"
}
