//
//  GetPhotoRequest.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import Foundation
extension PhotoModel: DecodableResponse {}

class GetPhotoRequest: AcademyRequest {
    typealias Response = PhotoModel
    
    var headerFields: [String : String] = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    let method: HTTPMethod = .get
    var academyPath: AcademyPath
    
    init(id: String) {
        academyPath = .getPicture(id: id)
    }
    
    func getImage(completion: @escaping(Result<Data, Error>) -> Void) {
        let defaults = UserDefaults.standard
        guard let token = defaults.value(forKey: Defines.Keys.accessTokenKey) as? String, !token.isEmpty else { return }
        var request = URLRequest(url: URL(string: baseURL.absoluteString + self.academyPath.string)!, timeoutInterval: Double.infinity)
        for (key, value) in headerFields {
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            completion(.success(data))
        }

        task.resume()
    }
    
    deinit {
        printDeinit(self)
    }
}
