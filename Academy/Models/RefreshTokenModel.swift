

import Foundation

struct RefreshTokenModel: Decodable {
    let accessToken: String?
//    let expireAt: String?
//    let expiresAt: String?
    let refreshToken: String?
//    let server: Int?
//    let database: Int?
//    let version: Int?
}

//{
//  "access_token": "dd67c0c1-5f14-4424-ad1f-cd746bd38223",
//  "expire_at": "2021-04-24T20:51:29.277Z",
//  "expires_at": "2021-04-24T20:51:29.277Z",
//  "refresh_token": "6760bc6e-4ac6-4a1a-a7be-cdf96705bc64",
//  "server": 1,
//  "database": 826618,
//  "version": 902
//}
