//
//  ScheduleCategoryViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import Foundation

protocol ScheduleCategoryViewModelType {
    //getters
    var onReload: (() -> Void) { get set }
    var groupsCategory: [CategoryGroupsModel] { get }
    //function
    func route(to route: ScheduleCategoryCoordinator.Route)
    func getPhotoCategory(id: String, completion: @escaping (Data) -> Void)
}

class ScheduleCategoryViewModel: ScheduleCategoryViewModelType {
    
    fileprivate let coordinator: ScheduleCategoryCoordinator
    private var userService: UserServiceType
    private var groupsService: GroupsServiceType
    private var coachService: CoachServiceType
    
    var onReload: (() -> Void) = { }
    var groupsCategory: [CategoryGroupsModel] = []
    
    init(_ coordinator: ScheduleCategoryCoordinator) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        self.groupsService = ServiceHolder.shared.get(by: GroupsService.self)
        self.coachService = ServiceHolder.shared.get(by: CoachService.self)
        self.getAllGroupSchedule()
    }
    
    private func getAllGroupSchedule() {
        groupsService.getCategoryGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                self.groupsCategory = response
                self.onReload()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getPhotoCategory(id: String, completion: @escaping (Data) -> Void) {
        groupsService.getPhoto(id: id) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension ScheduleCategoryViewModel {
    func route(to route: ScheduleCategoryCoordinator.Route) {
        coordinator.route(to: route)
    }
}
