//
//  HomeViewModel.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import Foundation

protocol HomeViewModelType {
    //getters
    var filterModel: GetClientCardModel? { get }
    var clientModel: ClientModel? { get }
    var onReload: (() -> Void) { get set }
    //func
    func route(to route: HomeCoordinator.Route)
}

class HomeViewModel: HomeViewModelType {
    
    private var coordinator: HomeCoordinator
    private var userService: UserServiceType
    var filterModel: GetClientCardModel?
    var clientModel: ClientModel?
    var onReload: (() -> Void) = { }
    
    init(_ coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        self.getClients()
    }
    
    private func refreshToken() {
        userService.refreshToken {
            self.getClients()
        }
    }
    
    private func getClients() {
        userService.getClients { [weak self] (result) in
//            guard let self = self else { return }
            switch result {
            
            case .success(let model):
                UserDefaults.standard.setValue(model.id, forKey: Defines.Keys.clientId)
                self?.getClientCard(clientId: model.id ?? "")
                self?.clientModel = model
            case .failure(let error):
                print(error.localizedDescription)
                self?.refreshToken()
            }
        }
    }
    
    private func getClientCard(clientId: String) {
        
        userService.getClientCard(client: clientId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            
            case .success(let response):
                
                _ = response.map { model in
                    if model.discount?.groups == nil && model.activated == true{
                        if model.endDate?.convertISOToDate() ?? Date() >= Date(){
                            self.filterModel = model
                            return
                        }
                    }else{
                        if model.endDate?.convertISOToDate() ?? Date() >= Date(){
                            self.filterModel = model
                            self.onReload()
                            return
                        }
                    }
                }
                self.onReload()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Navigation -

extension HomeViewModel {
    func route(to route: HomeCoordinator.Route) {
        coordinator.route(to: route)
    }
}
