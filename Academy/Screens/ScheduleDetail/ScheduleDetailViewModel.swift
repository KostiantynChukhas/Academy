//
//  ScheduleDetailViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

struct FreeTimeModelResponse: Decodable {
    let dateString: String
    let name: String
    let scheduleValue: String
    let coachModel: CoachModel?
    let date: Date?
}

struct ScheduleDates {
    var month: String
    var dates: [Date]
    var nameCoach: String
}

protocol ScheduleDetailViewModelType {
    //getters
    var onReload: (() -> Void) { get set }
    var scheduleResult: [ScheduleDates] { get }
    //func
    func route(to route: ScheduleDetailCoordinator.Route)
}

class ScheduleDetailViewModel: ScheduleDetailViewModelType {
    
    fileprivate let coordinator: ScheduleDetailCoordinator
    private var userService: UserServiceType
    private var groupsService: GroupsServiceType
    
    var onReload: (() -> Void) = { }
    var allGroupScheduleModel: GroupsModel
    var scheduleResult: [ScheduleDates] = []
    
    init(_ coordinator: ScheduleDetailCoordinator, allGroupScheduleModel: GroupsModel) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        self.groupsService = ServiceHolder.shared.get(by: GroupsService.self)
        self.allGroupScheduleModel = allGroupScheduleModel
        getAllGroupLessons()
    }
    
    private func getAllGroupLessons() {
        guard let group = allGroupScheduleModel.id else { return }
        
        groupsService.getAllGroupLessons(group: group, professional: "") { [weak self ] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let response):
                let dates = response.compactMap({$0.date?.convertISOToDate()})
                let monthDictionary = Date.dateDictionary(from: dates)
                let coachName = response.compactMap({$0.professionalName})
              
                monthDictionary.keys.forEach { key in
                    let scheduleDate = ScheduleDates(month: key.capitalized,
                                                     dates: monthDictionary[key] ?? [],
                                                     nameCoach: "\(coachName.first ?? "")")
                    self.scheduleResult.append(scheduleDate)
                }
                self.onReload()
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

extension ScheduleDetailViewModel {
    func route(to route: ScheduleDetailCoordinator.Route) {
        coordinator.route(to: route)
    }
}

