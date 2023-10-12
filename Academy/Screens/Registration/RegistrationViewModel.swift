
import Foundation

protocol RegistrationViewModelType {
    func route(to route: RegistrationCoordinator.Route)
    
    func createUser(firstname: String, lastname: String, middlename: String, phone: String, birthday:String,description: String,completion: @escaping(Result<CreateNewClientModel, Error>) -> Void)
    func uploadImage(clientId: String, completion: @escaping(Result<PutCreatePhotoClientModel, Error>) -> Void)
}

class RegistrationViewModel: RegistrationViewModelType {
    
    fileprivate let coordinator: RegistrationCoordinator
    private var userService: UserServiceType
    
    init(_ coordinator: RegistrationCoordinator) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
    }
    
    private func getDatabaseToken(completion: @escaping(Result<DatabaseTokenModel, Error>) -> Void) {
        userService.getDatabaseToken { [weak self] (result) in
            switch result {
            
            case .success(let response):
                UserDefaults.standard.setValue(response.accessToken, forKey: Defines.Keys.accessTokenKey)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createUser(firstname: String, lastname: String, middlename: String, phone: String, birthday:String,description: String,completion: @escaping(Result<CreateNewClientModel, Error>) -> Void) {
        
        let cardNumber = "\(phone.prefix(3))"
        
        getDatabaseToken {[weak self] (result) in
            DispatchQueue.main.async {
                self?.userService.createUser(firstname: firstname,lastname: lastname, middlename: middlename,phone: phone,birthday: birthday,description: description,cardNumber: cardNumber){ [weak self] (result) in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func uploadImage(clientId: String, completion: @escaping(Result<PutCreatePhotoClientModel, Error>) -> Void) {
        userService.putPhoto(clientId: clientId) { (result) in
            switch result {
            
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension RegistrationViewModel {
    
    func route(to route: RegistrationCoordinator.Route) {
        coordinator.route(to: route)
    }
}
