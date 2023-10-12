//
//  PutCreatePhotoClientRequest.swift

import Foundation

extension PutCreatePhotoClientModel: DecodableResponse {}

class PutCreatePhotoClientRequest: AcademyRequest {
    typealias Response = PutCreatePhotoClientModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    
    let method: HTTPMethod = .put
    var contentType: ContentType = .json
    var academyPath: AcademyPath
    
    var bodyParameters: [String : Any] = [:]
    
    init(clientId: String) {
        academyPath = .clientPhoto(clientId: clientId)
    }
    
    deinit {
        printDeinit(self)
    }
}
