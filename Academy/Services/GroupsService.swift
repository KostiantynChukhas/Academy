//
//  GroupsService.swift
//  Academy
//
//  Created by Konstantin Chukhas on 23.11.2021.
//

import Foundation

protocol GroupsServiceType: Service {
    func getGroups(completion: @escaping(Result<[GroupsModel], Error>) -> Void)
    func getCategoryGroups(completion: @escaping(Result<[CategoryGroupsModel], Error>) -> Void)
    func getFreeTimeCoaches(today: Date, completion: @escaping(Result<NSDictionary, Error>) -> Void)
    func getAllGroupSchedule(completion: @escaping(Result<[AllGroupScheduleModel], Error>) -> Void)
    func getGroupByIdSchedule(completion: @escaping(Result<[AllGroupScheduleModel], Error>) -> Void)
    func getAllGroupLessons(group: String, professional: String, completion: @escaping(Result<[AllGroupLessonsModel], Error>) -> Void)
    func getPhoto(id: String, completion: @escaping(Result<Data, Error>) -> Void)
}

class GroupsService: GroupsServiceType {
    
    func getGroupByIdSchedule(completion: @escaping (Result<[AllGroupScheduleModel], Error>) -> Void) {
        
    }
    
    
    func getCategoryGroups(completion: @escaping(Result<[CategoryGroupsModel], Error>) -> Void) {
        let request = GetCategoryGroupsRequest()
        
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
    
    func getGroups(completion: @escaping(Result<[GroupsModel], Error>) -> Void) {
        
        let request = GetGroupsRequest()
        
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
    
    func getFreeTimeCoaches(today: Date, completion: @escaping(Result<NSDictionary, Error>) -> Void) {
        GetFreeTimeRequest(from: Date()).getFreeTime { [weak self] result in
            guard let _ = self else { return }
            switch result {
            
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllGroupSchedule(completion: @escaping(Result<[AllGroupScheduleModel], Error>) -> Void) {
        let request = AllGroupScheduleRequest()
        
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
    
    func getAllGroupLessons(group: String, professional: String, completion: @escaping(Result<[AllGroupLessonsModel], Error>) -> Void) {
        AllGroupLessonsRequest(group: group, professional: professional).getGroupLessons { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func getPhoto(id: String, completion: @escaping(Result<Data, Error>) -> Void) {
        GetPhotoRequest(id: id).getImage { [weak self] result in
            switch result {
            
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    deinit {
        printDeinit(self)
    }
}
