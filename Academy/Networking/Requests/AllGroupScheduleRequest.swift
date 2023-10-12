//
//  AllGroupScheduleRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 28.11.2021.
//

import Foundation
extension AllGroupScheduleModel: DecodableResponse {}

class AllGroupScheduleRequest: AcademyRequest {
    typealias Response = [AllGroupScheduleModel]
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init() {
        academyPath = .getAllGroupSchedule(guery: "location,group,group_name,professionals,professionals_names")
    }
    
    deinit {
        printDeinit(self)
    }
}
