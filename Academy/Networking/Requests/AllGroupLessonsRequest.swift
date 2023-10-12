//
//  AllGroupLessonsRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 28.11.2021.
//

import Foundation
extension AllGroupLessonsModel: DecodableResponse {}

class AllGroupLessonsRequest: AcademyRequest {
    typealias Response = [AllGroupLessonsModel]
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(group: String, professional: String) {
        let today = Date()
        let threeMonthNext = Calendar.current.date(byAdding: .month, value: 3, to: today) ?? Date()
        let fromString = today.toString(with: "yyyy-MM-dd")
        let to = threeMonthNext.toString(with: "yyyy-MM-dd")
        
        var query = "date,duration,location,group,group_name,group_price,group_picture,professional,professional_name,assistant,assistant_name,hall,filled_completely,descriptionPlaintext&from=\(fromString)&to=\(to)&public=true&has_location_prices=true&publicProfessional=true"
        
        if group.isEmpty {
            query = query + "&professional=\(professional)"
        }else{
            query = query + "&group=\(group)"
        }
        academyPath = .getAllGroupLessons(guery: query)
        
    }
    
    func getGroupLessons(completion: @escaping(Result<[AllGroupLessonsModel], Error>) -> Void) {
        var request = URLRequest(url: URL(string: baseURL.absoluteString + self.academyPath.string)!, timeoutInterval: Double.infinity)
        for (key, value) in headerFields {
            request.addValue(value, forHTTPHeaderField: key)
        }
        let userDefaults = UserDefaults.standard
        let token = userDefaults.string(forKey: Defines.Keys.accessTokenKeyDatabase)
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                    completion(.failure(error!))
                return
            }
                let response = try? CustomDecoder().decode([AllGroupLessonsModel].self, from: data)
                completion(.success(response ?? [AllGroupLessonsModel]()))
        }
        
        task.resume()
    }
    
    deinit {
        printDeinit(self)
    }
}
