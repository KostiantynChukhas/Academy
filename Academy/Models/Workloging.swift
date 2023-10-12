
import Foundation

struct Worklog: Codable {
    
    var user_id: String = ""
    var ticket_id: String = ""
    var reported_time: Int = 0
    var type: String = ""
    var comment: String = ""
    var date: String = ""
}

/*
 
 {
   "user_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
   "ticket_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
   "reported_time": 0,
   "type": "Overtime",
   "comment": "string",
   "date": "string"
 }
 */

struct WorklogResponse: Codable {
    
    let id: String
    let projectId: String?
    let userId: String
    let ticketId: String
    let type: String
    let date: String
    let reportedTime: Int
    let approvedTime: Int
    let billedTime: Int?
    let comment: String?
}

struct EmptyResponse: Codable {
    
}

/*
 {
   "id": "931183c0-bfb0-4622-9d45-c2c004a20298",
   "project_id": "91fa1183-2acb-449c-9610-1fc8fb22033a",
   "user_id": "91fa1095-cb16-4522-af0e-b4000848c0bf",
   "ticket_id": "91fa12f7-7dc2-4588-aca2-7118075834c8",
   "type": "Regular",
   "date": "2021-03-29T00:00:00.000000Z",
   "reported_time": 300,
   "approved_time": 300,
   "billed_time": null,
   "project_item_id": "91fa119b-9177-49b4-8111-785ce73057a0",
   "comment": "Created from iOS",
   "status": "new",
   "is_internal": true,
   "trashed": false
 }
*/
