//
//  MyCardsViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol MyCardsViewModelType {
    //getters
    var onReload: (() -> Void) { get set }
    var filterModel: GetClientCardModel? { get }
    var endDate: String? { get }
    //func
    func route(to route: MyCardsCoordinator.Route)
}

class MyCardsViewModel: MyCardsViewModelType {
    
    fileprivate let coordinator: MyCardsCoordinator
    private var userService: UserServiceType
    
    var onReload: (() -> Void) = { }
    var filterModel: GetClientCardModel?
    var endDate: String?
    
    init(_ coordinator: MyCardsCoordinator) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
        
        getClientCard()
    }
    
    private func getClientCard() {
        let clientId = UserDefaults.standard.string(forKey: Defines.Keys.clientId)
        userService.getClientCard(client: clientId ?? "") { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            
            case .success(let response):
                _ = response.map { model in
                    guard model.discount?.groups == nil && model.activated == true else {return}
                    guard model.endDate?.convertISOToDate() ?? Date() >= Date() else { return }
                    DispatchQueue.main.async {
                        self.filterModel = model
                        self.endDate = model.endDateConvert()
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

extension MyCardsViewModel {
    func route(to route: MyCardsCoordinator.Route) {
        coordinator.route(to: route)
    }
}
