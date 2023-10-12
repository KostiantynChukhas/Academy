//
//  GetCoachesRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 21.11.2021.
//

import Foundation
extension CoachModel: DecodableResponse {}

class GetCoachesRequest: AcademyRequest {
    typealias Response = [CoachModel]
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init() {
        academyPath = .getCoaches(query: "name,gender,photo_exists,positions,position_names,roles,archive")
    }
    
    deinit {
        printDeinit(self)
    }
}
