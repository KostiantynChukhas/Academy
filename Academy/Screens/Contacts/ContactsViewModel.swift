//
//  ContactsViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol ContactsViewModelType {
    //func
    func route(to route: ContactsCoordinator.Route)
}

class ContactsViewModel: ContactsViewModelType {
    
    fileprivate let coordinator: ContactsCoordinator
    
    init(_ coordinator: ContactsCoordinator) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("ContactsViewModel - deinit")
    }
}

// MARK: - Navigation -

extension ContactsViewModel {
    func route(to route: ContactsCoordinator.Route) {
        coordinator.route(to: route)
    }
}
