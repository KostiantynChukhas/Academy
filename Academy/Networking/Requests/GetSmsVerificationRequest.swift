
import Foundation

extension SmsVerificationModel: DecodableResponse {}

class GetSmsVerificationRequest: AcademyRequest {
    typealias Response = SmsVerificationModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(authId: String, code: String) {
        academyPath = .smsVerification(authId: authId, code: code)
    }
    
    deinit {
        printDeinit(self)
    }
}

