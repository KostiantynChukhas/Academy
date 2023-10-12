//
//  GetGroupsRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 23.11.2021.
//

import Foundation
extension GroupsModel: DecodableResponse {}

class GetGroupsRequest: AcademyRequest {
    typealias Response = [GroupsModel]
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init() {
        academyPath = .getGroups(query: "name,category,picture,pictureUrl,schedules,public,location_prices,archive")
    }
    
    deinit {
        printDeinit(self)
    }
}
