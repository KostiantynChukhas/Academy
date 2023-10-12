
// MARK: - ClienntModel
struct ClientModel: Decodable {
    let id: String?
    let name: String?
    let firstname: String?
    let lastname: String?
    let middlename: String?
    let title: String?
    let gender: String?
    let birthday: String?
    let location: String?
    let balance, bonus: Int?
    let cardNumber, phone: [String]?
    let email: [String]?
    let photoExists: Bool?
    let photo: String?
    let postalCode: String?
    let city: String?
    let street: String?
    let building: String?
    let apartment: String?
    let categories: [String]?
    let categoriesNames: [String]?
    let firstVisit: String?
    let firstVisitDescription: String?
    let lastVisit: String?
    let lastVisitDescription: String?
    let depositClient: String?
    let doNotSendSMSNotification: Bool?
    let doNotSendSMSPromotion: Bool?
    let doNotSendEmail: Bool?
    let referralSource: String?
    let referralSourceName: String?
    let status: String?
    let archive: Bool?
    let professional: String?
}

