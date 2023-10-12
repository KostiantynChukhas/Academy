//
//  ScheduleViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 12.11.2021.
//

import Foundation

protocol ScheduleViewModelType {
    //getters
    var onReload: (() -> Void) { get set }
    var groups: [GroupsModel] { get }
    var allGroupSchedule: [AllGroupScheduleModel] { get }
    var coachesList: [CoachModel] { get }
    //function
    func route(to route: ScheduleCoordinator.Route)
}

class ScheduleViewModel: ScheduleViewModelType {
    
    fileprivate let coordinator: ScheduleCoordinator
    private var userService: UserServiceType
    private var groupsService: GroupsServiceType
    private var coachService: CoachServiceType
    
    var onReload: (() -> Void) = { }
    var groups: [GroupsModel] = []
    var coachesList: [CoachModel] = []
    var allGroupSchedule: [AllGroupScheduleModel] = []
    var categoryId: String?
    
    init(_ coordinator: ScheduleCoordinator, categoryId: String) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        self.groupsService = ServiceHolder.shared.get(by: GroupsService.self)
        self.coachService = ServiceHolder.shared.get(by: CoachService.self)
        self.categoryId = categoryId
        getGroups()
        getCoaches()
        getDatabaseToken()
        getAllGroupSchedule()
    }
    
    private func getDatabaseToken() {
        userService.getDatabaseToken { [weak self] (result) in
            switch result {
            
            case .success(let response):
                UserDefaults.standard.setValue(response.accessToken, forKey: Defines.Keys.accessTokenKeyDatabase)
//                UserDefaults.standard.setValue(response.refreshToken, forKey: Defines.Keys.refreshTokenKey)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAllGroupSchedule() {
        groupsService.getAllGroupSchedule { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                print(self.categoryId)
                self.allGroupSchedule = response
                self.onReload()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getGroups() {
        groupsService.getGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                self.groups = response.filter({ $0.archive == false && $0.category == self.categoryId})
                self.onReload()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getCoaches() {
        coachService.getCoaches { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let response):
                self.coachesList = response
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

extension ScheduleViewModel {
    func route(to route: ScheduleCoordinator.Route) {
        coordinator.route(to: route)
    }
}
