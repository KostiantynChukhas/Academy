
import Foundation

struct SmsVerificationModel: Decodable {
  
    let accessToken: String
    let expireAt: String
    let expiresAt: String
    let refreshToken: String
    let server: Int
    let location: String
    let database: Int
    let version: Int
    let clientId: String
}




/*{
    "access_token": "a7571bb1-229d-4767-b521-5c6975f48df5",
    "expire_at": "2021-04-17T14:54:18.104Z",
    "expires_at": "2021-04-17T14:54:18.104Z",
    "refresh_token": "825c3cfd-cf59-46e1-bb10-537f322a7002",
    "server": 1,
    "location": "0f66c70d-e695-4db7-919c-04468fe69bbd",
    "database": 826618,
    "version": 901,
    "client_id": "88d8fb65-c6cc-0877-5ef8-8844772e82a7"
}
*/
