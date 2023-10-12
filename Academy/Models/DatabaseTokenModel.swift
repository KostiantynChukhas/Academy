
import Foundation

struct DatabaseTokenModel: Decodable {
    let refreshToken: String?
    let accessToken: String?
}
