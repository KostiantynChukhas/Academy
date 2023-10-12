//
//  AllGroupLessonsModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 28.11.2021.
//

import Foundation
// MARK: - AllGroupLessonsModelElement
struct AllGroupLessonsModel: Decodable {
    let id, date: String?
    let duration: Int?
    let location, group: String?
    let groupName: String?
    let groupPrice: Int?
    let groupPicture: Assistant?
    let professional: String?
    let professionalName: String?
    let assistant: Assistant?
    let assistantName: String?
    let hall: String?
    let filledCompletely: Bool?
    let descriptionPlaintext: String?

}

// MARK: - Assistant
struct Assistant: Codable {
}
