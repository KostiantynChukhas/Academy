//
//  GetFreeTimeRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 24.11.2021.
//

import Foundation

extension FreeTimeModel: DecodableResponse {}

class GetFreeTimeRequest: AcademyRequest {
    typealias Response = FreeTimeModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(from: Date) {
        let threeMonthNext = Calendar.current.date(byAdding: .month, value: 3, to: from) ?? Date()
        let fromString = from.toString(with: "yyyy-MM-dd")
        let threeMonthNextString = threeMonthNext.toString(with: "yyyy-MM-dd")
        
        academyPath = .getFreeTime(from: fromString, to: threeMonthNextString, duration: "60")
    }
    
    
    func getFreeTime(completion: @escaping(Result<NSDictionary, Error>) -> Void) {
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
                return
            }
            do {
                let fetchedDataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                completion(.success(fetchedDataDictionary ?? [:]))
            }catch{
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    deinit {
        printDeinit(self)
    }
}


