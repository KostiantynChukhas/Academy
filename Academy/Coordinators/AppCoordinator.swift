//
//  AppCoordinator.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

class AppCoordinator {
    private var window: UIWindow
    private let serviceHolder = ServiceHolder.shared
    
    private var authCoordinator: AuthCoordinator?
    private var tabCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    func start() {
        startInitialServices()
        chekToken()
    }
    
    
    
    private func getApplicationToken() {
        let request = ApplicationTokenRequest()
        
        AcademyAPILocator.shared.send(request) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.getRefreshToken()
                case .failure(_):
                    self?.startAuth()
                }
            }
            
        }
    }
    
    private func getRefreshToken() {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: Defines.Keys.refreshTokenKey) ?? ""
        let request = RefreshTokenRequest(refreshToken: token)
        
        AcademyAPILocator.shared.send(request) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    UserDefaults.standard.setValue(response.refreshToken, forKey: Defines.Keys.refreshTokenKey)
                    UserDefaults.standard.setValue(response.accessToken, forKey: Defines.Keys.accessTokenKey)
                    self?.enterApp()
                case .failure(_):
                    self?.startAuth()
                }
            }
        }
    }
    
    private func chekToken() {
        getApplicationToken()
    }
    
    private func startAuth() {
        tabCoordinator = nil
        
        authCoordinator = AuthCoordinator(window: window)
        authCoordinator?.transitions = self
        authCoordinator?.start()
    }
    
    private func enterApp() {
        authCoordinator = nil
        
        tabCoordinator = TabBarCoordinator(window: window, transitions: self)
        tabCoordinator?.start()
    }
}

//MARK: - Services routine -
extension AppCoordinator {
    
    private func startInitialServices() {
        AcademyAPILocator.populate(instance: AcademyAPI())
        
        let userService = UserService()
        let coachService = CoachService()
        let groupService = GroupsService()
        serviceHolder.add(UserService.self, for: userService)
        serviceHolder.add(CoachService.self, for: coachService)
        serviceHolder.add(GroupsService.self, for: groupService)
    }
}

// MARK: - AuthCoordinatorTransitions -

extension AppCoordinator: AuthCoordinatorTransitions {
    func didLoggedIn() {
        enterApp()
    }
}

// MARK: - TabBarCoordinatorTransitions -

extension AppCoordinator: TabBarCoordinatorTransitions {
    func didLogout() {
        startAuth()
    }
}
