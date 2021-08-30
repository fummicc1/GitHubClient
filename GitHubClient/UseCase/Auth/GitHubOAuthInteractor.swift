//
//  GitHubOAuthInteractor.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Combine

protocol AuthGatewayProtocol: AutoMockable {
    func persistAccessToken(_ accessToken: String) -> AnyPublisher<Void, Error>
    func registerAccessToken(_ accessToken: String) -> AnyPublisher<Void, Error>
    func onAccessTokenChanged() -> AnyPublisher<String, Error>
    func findAccessToken() -> AnyPublisher<String?, Error>
    func requestAccessToken(with code: String) -> AnyPublisher<String, Error>
}

class GitHubOAuthInteractor {
    
    private let authGateway: AuthGatewayProtocol
    
    init(authGateway: AuthGatewayProtocol) {
        self.authGateway = authGateway
    }
    
}


extension GitHubOAuthInteractor: GitHubOAuthIUseCaseProtocol {
    
    func checkHasAccessToken() -> AnyPublisher<Bool, Error> {
        authGateway.findAccessToken()
            .map({ $0 != nil })
            .eraseToAnyPublisher()
    }
    
    func findAccessToken() -> AnyPublisher<String?, Error> {
        authGateway.findAccessToken()
            .eraseToAnyPublisher()
    }
    
    func onReceiveAccessToken() -> AnyPublisher<String, Error> {
        authGateway.onAccessTokenChanged()
            .flatMap({ accessToken in
                self.authGateway.registerAccessToken(accessToken)
                    .map({ _ in accessToken })
            })
            .eraseToAnyPublisher()
    }
    
    func updateCode(_ code: String) -> AnyPublisher<Void, Error> {
        authGateway.requestAccessToken(with: code)
            .flatMap { accessToken in
                self.authGateway.persistAccessToken(accessToken)
            }
            .eraseToAnyPublisher()
    }
}
