

import Foundation


extension GetClientCardModel: DecodableResponse {}

class GetClientCardRequest: AcademyRequest {
    typealias Response = [GetClientCardModel]
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(client: String) {
        academyPath = .getClientCards(query: "name,client,activated,start_date,end_date,cancelled,sum,delayed_payments,total_visits,used_visits,left_visits,discount,bonus", client: client)
        
    }
    
    deinit {
        printDeinit(self)
    }
}
