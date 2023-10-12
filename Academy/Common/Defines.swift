//
//  Defines.swift
//  Hydra_iOS
//
//  Created by on 23.03.2021.
//

import Foundation

typealias EmptyClosureType = () -> ()
typealias SimpleClosure<T> = (T) -> ()

struct Defines {
    struct Keys {
        static let userLoggedIn = "user_logged_in"
        static let accessTokenKey = "access_token_key"
        static let accessTokenKeyDatabase = "access_token_key_database"
        static let refreshTokenKey = "refresh_token_key"
        static let clientId = "client_id"
    }
    
    struct Links {
        static let facebook = "https://www.facebook.com/CSAsporting/"
        static let instagram = "https://www.instagram.com/csa_sporting/"
    }
    
    struct Numbers {
        static let numberPhone = "0937050555"
    }
    
    static let baseUrl = URL(string: "https://api.aihelps.com/v1/")!
}
