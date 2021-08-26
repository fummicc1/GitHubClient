//
//  AuthGateway.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Combine

protocol AuthGatewayProtocol {
    func requestAccessToken(clientID: String, clientSecret: String, code: String) -> AnyPublisher<Void, Error>
}

protocol AuthClientProtocol {
    func requestAccessToken(clientID: String, clientSecret: String, code: String) -> AnyPublisher<String, Error>
}

class AuthGateway: AuthGatewayProtocol {
    
    private let authClient: AuthClientProtocol
    
    internal init(authClient: AuthClientProtocol) {
        self.authClient = authClient
    }
    
    func requestAccessToken(clientID: String, clientSecret: String, code: String) -> AnyPublisher<Void, Error> {
        return authClient.requestAccessToken(
            clientID: clientID,
            clientSecret: clientSecret,
            code: code
        )
        .map({ _ in () })
        .eraseToAnyPublisher()
    }
}
