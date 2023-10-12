//
//  ProfileViewModel.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import Foundation

protocol ProfileViewModelType {
    func getClients()
    func logout()
}

class ProfileViewModel: ProfileViewModelType {
    private let coordinator: ProfileCoordinator
    
    private let userService = ServiceHolder.shared.get(by: UserService.self)
    
    init(_ coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func getClients() {
//        userService.getClients()
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: Defines.Keys.accessTokenKey)
        UserDefaults.standard.removeObject(forKey: Defines.Keys.refreshTokenKey)
        UserDefaults.standard.synchronize()
        
        coordinator.logout()
    }
}
