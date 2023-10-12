

import Foundation

extension AuthModel: DecodableResponse {}

class GetLoginWithPhoneRequest: AcademyRequest {
    typealias Response = AuthModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(phone: String) {
        academyPath = .loginWithPhone(applicationId: AcademyAPI.aplicationId, databaseCode: AcademyAPI.dataBaseCode, phone: phone)
    }
    
    deinit {
        printDeinit(self)
    }
}

