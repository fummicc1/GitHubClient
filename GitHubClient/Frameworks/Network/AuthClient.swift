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
    static var accessTokenURL: URL = URL(string: "https://github.com/login/oauth/access_token")!
    static var authorizeURL: URL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(PrivateKey.githubClientID)")!
    static var callbackURL: URL = URL(string: "https://github.com/fummicc1/GitHubClient")!
}

enum AuthError: Error {
    case invalidURL(url: String)
}

class AuthClient: AuthClientProtocol {
    
    struct AccessToken: Decodable {
        let accessToken: String
        let tokenType: String
    }
    
    func requestAccessToken(with code: String) -> AnyPublisher<String, Error> {
        
        let clientID = PrivateKey.githubClientID
        let clientSecret = PrivateKey.githubClientSecret
        
        let url = AuthClientConst.accessTokenURL
        
        let method = HTTPMethod.post
        let params: [String: Any] = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code
        ]
        
        let headers = HTTPHeaders([
            .accept("application/json")
        ])
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return AF.request(url, method: method, parameters: params, headers: headers)
            .publishDecodable(type: AccessToken.self, decoder: decoder)
            .handleEvents(receiveOutput: { accessToken in
                dump(accessToken)
            })
            .compactMap({ $0.value })
            .map(\.accessToken)
            .mapError({ error in
                ApiErrors.errors([error])
            })
            .eraseToAnyPublisher()
    }
}
