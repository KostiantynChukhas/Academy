//
//  CoachesViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol CoachesViewModelType {
    //getters
    var coaches: [CoachModel] { get }
    var onReload: (() -> Void) { get set }
    
    //func
    func route(to route: CoachesCoordinator.Route)
    func selectFilter(_ positionName: [String])
    func getAvatarCoach(id: String, completion: @escaping (Data) -> Void)
}

class CoachesViewModel: CoachesViewModelType {
    
    fileprivate let coordinator: CoachesCoordinator
    private var coachService: CoachServiceType
    private var userService: UserServiceType
    
    var coaches: [CoachModel] = []
    var onReload: (() -> Void) = { }
    private var positionName: [String] = []
    
    init(_ coordinator: CoachesCoordinator) {
        self.coordinator = coordinator
        self.coachService = ServiceHolder.shared.get(by: CoachService.self)
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        self.getCoaches(false)
        getDatabaseToken()
    }
    
    private func getDatabaseToken() {
        userService.getDatabaseToken { [weak self] (result) in
            guard let _ = self else { return }
            switch result {
            
            case .success(let response):
                UserDefaults.standard.setValue(response.accessToken, forKey: Defines.Keys.accessTokenKeyDatabase)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getCoaches(_ isSuccess: Bool) {
        coachService.getCoaches { [weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let response):
                let filtered = response.filter({ $0.roles?.first == .professional && $0.archive == false })
                self.coaches = filtered
                if isSuccess {
                    self.coaches.removeAll()
                    _ = self.positionName.compactMap { position in
                        filtered.compactMap { coachModel in
                            guard (coachModel.positionNames?.first?.contains(position) ?? false) else { return }
                                self.coaches.append(coachModel)
                        }
                    }
                }
                
                self.onReload()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAvatarCoach(id: String, completion: @escaping (Data) -> Void) {
        coachService.getAvatarCoaches(id: id) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func selectFilter(_ positionName: [String]) {
        self.positionName = positionName
        guard self.positionName.isEmpty else {
            self.getCoaches(true)
            return
        }
        self.getCoaches(false)
        
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension CoachesViewModel {
    func route(to route: CoachesCoordinator.Route) {
        coordinator.route(to: route)
    }
}
