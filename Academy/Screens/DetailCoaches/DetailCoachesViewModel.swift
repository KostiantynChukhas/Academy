//
//  DetailCoachesViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol DetailCoachesViewModelType {
    //getters
    var onReload: (() -> Void) { get set }
    var scheduleResult: [ScheduleDates] { get }
    var imageDataAvatar: Data { get }
    var filterModel: GetClientCardModel? { get }
    
    //func
    func route(to route: DetailCoachesCoordinator.Route)
}

class DetailCoachesViewModel: DetailCoachesViewModelType {

    fileprivate let coordinator: DetailCoachesCoordinator
    private var userService: UserServiceType
    private var groupsService: GroupsServiceType
    
    var onReload: (() -> Void) = { }
    var scheduleResult: [ScheduleDates] = []
    var coachModel: CoachModel
    var imageDataAvatar: Data
    var filterModel: GetClientCardModel?
    
    init(_ coordinator: DetailCoachesCoordinator, coachModel: CoachModel, imageDataAvatar: Data) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        self.groupsService = ServiceHolder.shared.get(by: GroupsService.self)
        
        self.coachModel = coachModel
        self.imageDataAvatar = imageDataAvatar
//        getFreeTime()
        getAllGroupLessons()
        getClientCard()
    }
    
    private func getAllGroupLessons() {
        guard let professional = coachModel.id else { return }
        
        groupsService.getAllGroupLessons(group: "", professional: professional) { [weak self ] result in
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
    
    private func getClientCard() {
        let clientId = UserDefaults.standard.string(forKey: Defines.Keys.clientId) ?? ""
        userService.getClientCard(client: clientId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            
            case .success(let response):
//                guard let filterModel = response.filter({$0.discount?.groups == nil}).first else {return}
                _ = response.map { model in
                    guard model.discount?.groups == nil && model.activated == true else {return}
                    guard model.endDate?.convertISOToDate() ?? Date() >= Date() else { return }
                    DispatchQueue.main.async {
                        self.filterModel = model
                    }
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

extension DetailCoachesViewModel {
    func route(to route: DetailCoachesCoordinator.Route) {
        coordinator.route(to: route)
    }
}


