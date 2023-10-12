

import Foundation

protocol UserServiceType: Service {
    var clientModel: ClientModel? { get set}
    
    func login(userPhone:String, completion: @escaping (Result<String, Error>) -> ())
    func smsVerification(authId: String, code: String, completion: @escaping (Result<SmsVerificationModel, Error>) -> ())
    func getClients(completion: @escaping(Result<ClientModel, Error>) -> Void)
    func getClientCard(client: String, completion: @escaping(Result<[GetClientCardModel], Error>) -> Void)
    //registration
    func getDatabaseToken(completion: @escaping(Result<DatabaseTokenModel, Error>) -> Void)
    func createUser(firstname: String, lastname: String, middlename: String, phone: String, birthday:String,description: String,cardNumber: String,completion: @escaping(Result<CreateNewClientModel, Error>) -> Void )
    func putPhoto(clientId:String, completion: @escaping(Result<PutCreatePhotoClientModel, Error>) -> Void)
    func refreshToken(completion: @escaping() -> Void)
}

class UserService: UserServiceType {
    
    var clientModel: ClientModel?
    
    func login(userPhone:String, completion: @escaping (Result<String, Error>) -> ()) {
        let request = GetLoginWithPhoneRequest(phone: userPhone)
        
        AcademyAPILocator.shared.send(request) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.authId))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func smsVerification(authId: String, code: String, completion: @escaping (Result<SmsVerificationModel, Error>) -> ()) {
        let request = GetSmsVerificationRequest(authId: authId, code: code)
        
        AcademyAPILocator.shared.send(request) { result in
            switch result {
            case .success(let response): completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func getClients(completion: @escaping(Result<ClientModel, Error>) -> Void) {
        
        let request = GetClientsRequest()
        
        AcademyAPILocator.shared.send(request) { result in
            switch result {
            case .success(let response):
                self.clientModel = response
                UserDefaults.standard.set(response.balance, forKey: "balance")
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func getClientCard(client: String, completion: @escaping (Result<[GetClientCardModel], Error>) -> Void) {
        let request = GetClientCardRequest(client: client)
        
        AcademyAPILocator.shared.send(request) { result in
            switch result {
            case .success(let response):
               completion(.success(response))
//                let path = Bundle.main.path(forResource: "mokup", ofType: "json")
//                let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path!))
//            do {
//                let response = try CustomDecoder().decode([GetClientCardModel].self, from: jsonData)
//                print("DecodableResponse decode response \(response)")
//                completion(.success(response))
//            } catch {
//                print("DecodableResponse response error \(error.localizedDescription)") // here.....
//                completion(.failure(error))
//            }

            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func getDatabaseToken(completion: @escaping (Result<DatabaseTokenModel, Error>) -> Void) {
        let request = DatabaseTokenRequest()
        
        AcademyAPILocator.shared.send(request) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func refreshToken(completion: @escaping() -> Void) {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: Defines.Keys.refreshTokenKey) ?? ""
        let request = RefreshTokenRequest(refreshToken: token)

        AcademyAPILocator.shared.send(request) { [weak self] (result) in

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    UserDefaults.standard.setValue(response.refreshToken, forKey: Defines.Keys.refreshTokenKey)
                    UserDefaults.standard.setValue(response.accessToken, forKey: Defines.Keys.accessTokenKey)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func createUser(firstname: String, lastname: String, middlename: String, phone: String, birthday:String,description: String,cardNumber: String,completion: @escaping(Result<CreateNewClientModel, Error>) -> Void ) {
        let request = CreateNewClientRequest(firstname: firstname, lastname: firstname, middlename: middlename, phone: phone, birthday: birthday, cardNumber: cardNumber, description: description)
        
        AcademyAPILocator.shared.send(request) { (result) in
           
            switch result {
            
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putPhoto(clientId:String, completion: @escaping(Result<PutCreatePhotoClientModel, Error>) -> Void) {
        let request = PutCreatePhotoClientRequest(clientId: clientId)
        
        AcademyAPILocator.shared.send(request) { (result) in
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
