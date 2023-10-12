//
//  GetCoachIDRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 27.11.2021.
//

import Foundation
extension CoachModelById: DecodableResponse {}

class GetCoachIDRequest: AcademyRequest {
    typealias Response = CoachModelById
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(coachId: String) {
        academyPath = .getCoachById(coachId: coachId)
    }
    
    deinit {
        printDeinit(self)
    }
}
