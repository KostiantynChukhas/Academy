

import Foundation

import Foundation
extension DatabaseTokenModel: DecodableResponse {}

class DatabaseTokenRequest: AcademyRequest {
    typealias Response = DatabaseTokenModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init() {
        academyPath = .databaseToken(applicationId: AcademyAPI.aplicationId, applicationSecret: AcademyAPI.applicationSecret, databaseCode: AcademyAPI.dataBaseCode)
        
    }
    
    deinit {
        printDeinit(self)
    }
}
