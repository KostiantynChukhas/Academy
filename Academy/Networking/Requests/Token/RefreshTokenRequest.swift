

import Foundation
extension RefreshTokenModel: DecodableResponse {}

class RefreshTokenRequest: AcademyRequest {
    typealias Response = RefreshTokenModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(refreshToken: String) {
        academyPath = .refreshToken(applicationId: AcademyAPI.aplicationId, refreshToken: refreshToken)
        
    }
    
    deinit {
        printDeinit(self)
    }
}
