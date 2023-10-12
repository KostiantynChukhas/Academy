//
//  CategoryGroupsModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import Foundation

struct CategoryGroupsModel: Decodable {
    let id: String
    let name: String?
    let archive: Bool
    let picture: String?
}

