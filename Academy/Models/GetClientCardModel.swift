

import Foundation

struct GetClientCardModel: Decodable {
    let id: String
    let client: String
    let name: String
    let sum: Int?
    let startDate: String?
    let endDate: String?
    let totalVisits: TotalVisits?
    let usedVisits: Int?
    let leftVisits: Int?
    let discount: Discount?
    let activated: Bool
}

struct Discount: Decodable {
    let groups: Groups?
    let services: [String: ServiceDiscount]?
}

// MARK: - Service
struct ServiceDiscount: Decodable {
    let totalQuantity, usedQuantity, leftQuantity, discount: Int?
}


struct Groups: Decodable {
    let all: Int?
}

enum TotalVisits: Decodable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(TotalVisits.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TotalVisits"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}




extension GetClientCardModel {
    func endDateConvert() -> String {
        let df = DateFormatter()
        df.locale = .current
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = df.date(from: endDate ?? "") else { return "" }
        let dfConverted = DateFormatter()
        dfConverted.dateFormat = "dd.MM.yy"
        let stringDate = dfConverted.string(from: date)
        return stringDate
    }
    
    func startDateConvert() -> String {
        let df = DateFormatter()
        df.locale = .current
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = df.date(from: startDate ?? "") else { return "" }
        let dfConverted = DateFormatter()
        dfConverted.dateFormat = "dd.MM.yy"
        let stringDate = dfConverted.string(from: date)
        return stringDate
    }
    
    func compareDateFromToday() -> Bool {
        let df = ISO8601DateFormatter()
        let today = Date()
        guard let endDateAboniment = df.date(from: endDate ?? "") else { return false }
        if endDateAboniment < today {
            return true
        }else {
            return false
        }
    }
}

/*
[
    {
        "id": "88d90bed-8e25-44a7-73ce-dff47a039e98",
        "name": "Посещение зала 1 месяц",
        "client": "88d904d4-8796-5362-0f3a-62955b43db50",
        "activated": true,
        "start_date": "2021-04-30T00:00:00.000Z",
        "end_date": "2021-05-30T00:00:00.000Z",
        "cancelled": false,
        "sum": 0,
        "delayed_payments": null,
        "total_visits": "unlimited",
        "used_visits": 0,
        "left_visits": 0,
        "discount": {
            "services": {
                "88d90576-154c-a94f-45ec-85d05f045cb8": {
                    "total_quantity": 0,
                    "used_quantity": 0,
                    "left_quantity": 0,
                    "discount": 100
                },
                "88d9057b-7c85-8614-45ec-85d04d04a1c8": {
                    "total_quantity": 0,
                    "used_quantity": 0,
                    "left_quantity": 0,
                    "discount": 100
                }
            }
        },
        "bonus": {},
        "accumulated_bonus": null
    }
]
*/
