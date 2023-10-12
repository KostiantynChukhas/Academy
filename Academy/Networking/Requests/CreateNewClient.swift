

import Foundation

extension CreateNewClientModel: DecodableResponse {}

class CreateNewClientRequest: AcademyRequest {
    typealias Response = CreateNewClientModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    
    let method: HTTPMethod = .post
    var academyPath: AcademyPath = .createCliient(query: "firstname%2Cmiddlename%2Clastname%2Cbirthday%2Ccard_number%2Cphone%2Cdescription")
    
    var bodyParameters: [String : Any] = [:]
    
    init(firstname: String, lastname: String, middlename: String, phone: String, birthday:String, cardNumber: String, description: String) {
        bodyParameters["firstname"] = firstname
        bodyParameters["lastname"] = lastname
        bodyParameters["middlename"] = middlename
        bodyParameters["phone"] = phone
        bodyParameters["birthday"] = birthday
        bodyParameters["card_number"] = cardNumber
    }
    
    deinit {
        printDeinit(self)
    }
}
