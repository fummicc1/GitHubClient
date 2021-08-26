//
//  AuthClient.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Alamofire
import Combine

enum AuthClientConst {
    static var url: String = "https://github.com/login/oauth/authorize"
}

enum AuthError: Error {
    case invalidURL(url: String)
}

class AuthClient: AuthClientProtocol {
    
    struct AccessToken: Decodable {
        let accessToken: String
        let tokenType: String
    }
    
    func requestAccessToken(clientID: String, clientSecret: String, code: String) -> AnyPublisher<String, Error> {
        
        guard let url = URL(string: AuthClientConst.url) else {
            return Fail(error: AuthError.invalidURL(url: AuthClientConst.url))
                .eraseToAnyPublisher()
        }
        
        let method = HTTPMethod.post
        let params: [String: Any] = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code
        ]
        
        return AF.request(url, method: method, parameters: params)
            .publishData()
            .value()
            .compactMap({ $0 })
            .compactMap { data in
                try? JSONDecoder().decode(AccessToken.self, from: data)
            }
            .map(\.accessToken)
            .mapError({ afError in
                ApiErrors.errors([afError])
            })
            .eraseToAnyPublisher()
    }
}
