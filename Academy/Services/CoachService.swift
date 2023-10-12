//
//  CoachService.swift
//  Academy
//
//  Created by Konstantin Chukhas on 21.11.2021.
//

import Foundation

protocol CoachServiceType: Service {
    
    func getCoaches(completion: @escaping(Result<[CoachModel], Error>) -> Void)
    func getAvatarCoaches(id: String, completion: @escaping(Result<Data, Error>) -> Void)
    func getCoachById(coachId: String, completion: @escaping(String) -> Void)
}

class CoachService: CoachServiceType {
    
    func getCoaches(completion: @escaping(Result<[CoachModel], Error>) -> Void) {
        
        let request = GetCoachesRequest()
        
        AcademyAPILocator.shared.send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func getAvatarCoaches(id: String, completion: @escaping(Result<Data, Error>) -> Void) {
        _ = GetPhotoCoach(coachId: id).getImage { [weak self] result in
            switch result {
            
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCoachById(coachId: String, completion: @escaping(String) -> Void) {
        let request = GetCoachIDRequest(coachId: coachId)
        
        AcademyAPILocator.shared.send(request) { result in
            switch result {
            case .success(let response):
                completion(response.name ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    deinit {
        printDeinit(self)
    }
}
