//
//  GetCategoryGroupsRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import Foundation
extension CategoryGroupsModel: DecodableResponse {}

class GetCategoryGroupsRequest: AcademyRequest {
    typealias Response = [CategoryGroupsModel]
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init() {
        academyPath = .getGroupsCategory(query: "name,parent,picture,archive")
    }
    
    deinit {
        printDeinit(self)
    }
}
