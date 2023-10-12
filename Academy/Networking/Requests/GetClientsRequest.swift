
import Foundation

extension ClientModel: DecodableResponse {}

class GetClientsRequest: AcademyRequest {
    typealias Response = ClientModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath = .getClients
    
    deinit {
        printDeinit(self)
    }
}

