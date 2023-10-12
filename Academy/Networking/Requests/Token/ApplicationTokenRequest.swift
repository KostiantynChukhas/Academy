

import Foundation


extension AplicationTokenModel: DecodableResponse {}

class ApplicationTokenRequest: AcademyRequest {
    typealias Response = AplicationTokenModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init() {
        academyPath = .aplicationToken(applicationId: AcademyAPI.aplicationId, applicationSecret: AcademyAPI.applicationSecret)
    }
    
    deinit {
        printDeinit(self)
    }
}
