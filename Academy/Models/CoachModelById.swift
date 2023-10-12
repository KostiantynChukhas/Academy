//
//  CoachModelById.swift
//  Academy
//
//  Created by Konstantin Chukhas on 27.11.2021.
//

import Foundation
// MARK: - CoachModelElement
struct CoachModelById: Decodable {
    let id, name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
