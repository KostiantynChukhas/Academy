//
//  GroupCardsViewModel.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import Foundation

protocol GroupCardsViewModelType {
    //getters
    var onReload: (() -> Void) { get set }
    var filterModel: GetClientCardModel? { get }
    var endDate: String? { get }
    //func
    func route(to route: GroupCardsCoordinator.Route)
}

class GroupCardsViewModel: GroupCardsViewModelType {
    
    fileprivate let coordinator: GroupCardsCoordinator
    private var userService: UserServiceType
    
    var onReload: (() -> Void) = { }
    var filterModel: GetClientCardModel?
    var endDate: String?
    
    init(_ coordinator: GroupCardsCoordinator) {
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
                guard let filterModel = response.filter({$0.discount?.groups != nil}).first else {return}
                self.filterModel = filterModel
                self.endDate = filterModel.endDateConvert()
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

extension GroupCardsViewModel {
    func route(to route: GroupCardsCoordinator.Route) {
        coordinator.route(to: route)
    }
}
