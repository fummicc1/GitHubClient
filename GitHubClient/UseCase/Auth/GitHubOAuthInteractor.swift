//
//  GitHubOAuthInteractor.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Combine

protocol AuthGatewayProtocol {
    func onAccessTokenChanged() -> AnyPublisher<String, Error>
    func getAccessToken() -> AnyPublisher<String?, Error>
    func requestAccessToken(with code: String) -> AnyPublisher<Void, Error>
}

class GitHubOAuthInteractor {
    
    private let authGateway: AuthGatewayProtocol
    
    init(authGateway: AuthGatewayProtocol) {
        self.authGateway = authGateway
    }
    
}


extension GitHubOAuthInteractor: GitHubOAuthIUseCaseProtocol {
    
    func checkHasAccessToken() -> AnyPublisher<Bool, Error> {
        authGateway.getAccessToken()
            .map({ $0 != nil })
            .eraseToAnyPublisher()
    }
    
    func getAccessToken() -> AnyPublisher<String?, Error> {
        authGateway.getAccessToken()
            .eraseToAnyPublisher()
    }
    
    func onAccessToken() -> AnyPublisher<String, Error> {
        authGateway.onAccessTokenChanged()
    }
    
    func updateCode(_ code: String) -> AnyPublisher<Void, Error> {
        authGateway.requestAccessToken(with: code)
    }
}
