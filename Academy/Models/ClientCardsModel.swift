//
//  ClientCardsModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.12.2021.
//

import Foundation

// MARK: - ClientCardsModel
struct ClientCardsModel: Decodable {
    let id, name, client: String?
    let activated: Bool?
    let start_date, end_date: String?
    let cancelled: Bool?
    let sum: Int?
    let total_visits: TotalVisits?
    let used_visits, left_visits: Int?

    }

