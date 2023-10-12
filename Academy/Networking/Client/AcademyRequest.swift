import Foundation

enum AcademyPath {
    case unknown
    case loginWithPhone(applicationId: String, databaseCode: String, phone: String)
    case smsVerification(authId: String, code: String)
    case getClients
    case aplicationToken(applicationId: String, applicationSecret: String)
    case refreshToken(applicationId: String, refreshToken: String)
    case databaseToken(applicationId: String, applicationSecret: String, databaseCode: String)
    case createCliient(query: String)
    case clientPhoto(clientId: String)
    case getClientCards(query: String, client: String)
    case getCoaches(query: String)
    case coachPhoto(coachId: String)
    case getGroups(query: String)
    case getGroupsCategory(query: String)
    case getFreeTime(from: String, to: String, duration: String)
    case getCoachById(coachId: String)
    case getAllGroupSchedule(guery: String)
    case getAllGroupLessons(guery: String)
    case getPicture(id: String)
    
    var string: String {
        switch self {
        case .unknown: return "unknown"
        case .loginWithPhone(let aplicationId, let databaseCode, let phone): return "auth/client?application_id=\(aplicationId)&database_code=\(databaseCode)&phone=\(phone)"
        case .smsVerification(let authId, let code): return "auth/client?auth_id=\(authId)&code=\(code)&location=\(authId)"
        case .getClients: return "clients/me?fields=name,firstname,middlename,lastname,title,gender,birthday,location,balance,bonus,card_number,phone,email,photo_exists,photo,postal_code,city,street,building,apartment,categories,categories_names,first_visit,first_visit_description,last_visit,last_visit_description,feedback,additional_fields,do_not_send_sms_notification,do_not_send_sms_promotion,do_not_send_email,deposit_client,referral_source,referral_source_name,status,archive,professional"
        case .aplicationToken(let applicationId, let applicationSecret): return "auth/application?application_id=\(applicationId)&application_secret=\(applicationSecret)"
        case .refreshToken(let applicationId, let refreshToken): return "auth/refresh?application_id=\(applicationId)&refresh_token=\(refreshToken)"
        case .databaseToken(let applicationId, let applicationSecret, let databaseCode): return "auth/database?application_id=\(applicationId)&application_secret=\(applicationSecret)&database_code=\(databaseCode)"
        case .createCliient(let query): return "clients?fields=\(query)"
            //firstname%2Cmiddlename%2Clastname%2Cbirthday%2Ccard_number%2Cphone%2Cdescription"
        case .clientPhoto(let clientId): return "clients/\(clientId)"
        case .getClientCards(let query, let client): return "clientcards?fields=\(query)&client=\(client)"
        case .getCoaches(let query): return "employees?fields=\(query)"
        case .coachPhoto(let coachId): return "employees/\(coachId)/photo"
        case .getGroups(let query): return "groups?fields=\(query)"
        case .getFreeTime(let from, let to, let duration): return "employees/free_time?from=\(from)&to=\(to)&duration=\(duration)"
        case .getCoachById(let coachId): return "employees/\(coachId)?fields=name"
        case .getAllGroupSchedule(let query): return "groupschedules?fields=\(query)"
        case .getAllGroupLessons(let query): return "grouplessons?fields=\(query)"
        case .getGroupsCategory(let query): return "groups/categories?fields=\(query)&archive=false"
        case .getPicture(let id): return "pictures/\(id)/image"
        }
    }
}

protocol AcademyRequest: HTTPRequest {
    var academyPath: AcademyPath { get }
}

extension AcademyRequest {
    var path: String { return academyPath.string }
    var acceptType: AcceptType? {
        return .json
    }
}

extension AcademyRequest {
    var baseURL: URL { return Defines.baseUrl }
}

extension AcademyRequest where Response: DecodableResponse {
    func response(data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        do {
            let response = try Response.decode(data: data, urlResponse: urlResponse)
            print("AcademyRequest response \(response)")
            return response
        } catch {
            print("AcademyRequest response error \(error.localizedDescription)") // here.....
            throw error
        }
        
        //return try Response.decode(data: data, urlResponse: urlResponse)
    }

}

protocol DecodableResponse {
    static func decode(data: Data, urlResponse: URLResponse) throws -> Self
}

extension DecodableResponse where Self: Decodable {
    static func decode(data: Data, urlResponse _: URLResponse) throws -> Self {
        do {
            let response = try CustomDecoder().decode(Self.self, from: data)
            print("DecodableResponse decode response \(response)")
            return response
        } catch {
            print("DecodableResponse response error \(error.localizedDescription)") // here.....
            throw error
        }
        
        //return try CustomDecoder().decode(Self.self, from: data)
    }
}

extension AcademyRequest where Failure: DecodableFailure {
    func failure(data: Data, urlResponse: HTTPURLResponse) throws -> Failure {
        return try Failure.decode(data: data, urlResponse: urlResponse)
    }
}

protocol DecodableFailure {
    static func decode(data: Data, urlResponse: URLResponse) throws -> Self
}

extension DecodableFailure where Self: Decodable {
    static func decode(data: Data, urlResponse _: URLResponse) throws -> Self {
        return try CustomDecoder().decode(Self.self, from: data)
    }
}

extension Array: DecodableResponse where Element: Decodable {
    static func decode(data: Data, urlResponse _: URLResponse) throws -> [Element] {
        return try CustomDecoder().decode([Element].self, from: data)
    }
}

extension Result: DecodableResponse where Success: DecodableResponse, Failure: DecodableResponse {
    static func decode(data: Data, urlResponse: URLResponse) throws -> Result<Success, Failure> {
        let successParsingError: Error
        
        do {
            let success = try Success.decode(data: data, urlResponse: urlResponse)
            return .success(success)
        } catch {
            successParsingError = error
        }
        
        do {
            let failure = try Failure.decode(data: data, urlResponse: urlResponse)
            return .failure(failure)
        } catch {
            throw successParsingError
        }
    }
}
