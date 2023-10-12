//
//  ScheduleFilterViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol ScheduleFilterViewModelType {
    //func
    func route(to route: ScheduleFilterCoordinator.Route)
}

class ScheduleFilterViewModel: ScheduleFilterViewModelType {
    
    fileprivate let coordinator: ScheduleFilterCoordinator
    
    init(_ coordinator: ScheduleFilterCoordinator) {
        self.coordinator = coordinator
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension ScheduleFilterViewModel {
    func route(to route: ScheduleFilterCoordinator.Route) {
        coordinator.route(to: route)
    }
}
