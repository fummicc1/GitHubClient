//
//  AuthGateway.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Combine

protocol AuthClientProtocol {    
    func requestAccessToken(with code: String) -> AnyPublisher<String, Error>
}

class AuthGateway: AuthGatewayProtocol {
    
    private let authClient: AuthClientProtocol
    private let dataStore: DataStoreProtocol
    
    internal init(authClient: AuthClientProtocol, dataStore: DataStoreProtocol) {
        self.authClient = authClient
        self.dataStore = dataStore
    }
    
    func requestAccessToken(with code: String) -> AnyPublisher<Void, Error> {
        return authClient.requestAccessToken(with: code)
            .tryMap({ accessToken in
                try self.dataStore.save(accessToken, key: "github_access_token")
            })
            .eraseToAnyPublisher()
    }
    
    func getAccessToken() -> AnyPublisher<String?, Error> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            
            do {
                let token = try self.dataStore.get(key: "github_access_token")
                promise(.success(token))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func onAccessTokenChanged() -> AnyPublisher<String, Error> {
        dataStore.observe(key: "github_access_token")
    }
}