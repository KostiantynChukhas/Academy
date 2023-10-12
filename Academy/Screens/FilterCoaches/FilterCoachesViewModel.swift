//
//  FilterCoachesViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol FilterCoachesViewModelType {
    //get
    var coachModel: [CoachModel] { get }
    var onReload: (() -> Void) { get set }
    //func
    func route(to route: FilterCoachesCoordinator.Route)
    func selectFilter(_ positionName: [String])
}

class FilterCoachesViewModel: FilterCoachesViewModelType {
    
    fileprivate let coordinator: FilterCoachesCoordinator
    private var coachService: CoachServiceType
    
    var coachModel: [CoachModel] = []
    var onReload: (() -> Void) = { }
    
    init(_ coordinator: FilterCoachesCoordinator) {
        self.coordinator = coordinator
        self.coachService = ServiceHolder.shared.get(by: CoachService.self)
        self.getCoaches()
       
    }
    
    func selectFilter(_ positionName: [String]) {
        coordinator.selectFilter(positionName)
    }
    
    private func getCoaches() {
        coachService.getCoaches { [weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let response):
                let filtered = response.filter({ $0.roles?.first == .professional && $0.archive == false })
                self.coachModel = filtered.filterDuplicate{ ($0.positionNames?.first) }
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

extension FilterCoachesViewModel {
    func route(to route: FilterCoachesCoordinator.Route) {
        coordinator.route(to: route)
    }
}

