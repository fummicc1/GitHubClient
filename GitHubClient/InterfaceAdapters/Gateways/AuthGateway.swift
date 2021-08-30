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
    private let graphQLClient: GraphQLClientProtocol
    private let dataStore: DataStoreProtocol
    
    internal init(authClient: AuthClientProtocol, graphQLClient: GraphQLClientProtocol, dataStore: DataStoreProtocol) {
        self.authClient = authClient
        self.graphQLClient = graphQLClient
        self.dataStore = dataStore
    }
    
    func persistAccessToken(_ accessToken: String) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            do {
                try self.dataStore.save(accessToken, key: "github_access_token")
                promise(.success(()))
            }
            catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func registerAccessToken(_ accessToken: String) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            self.graphQLClient.configure(accessToken: accessToken)
            promise(.success(()))
        }.eraseToAnyPublisher()
    }
    
    func requestAccessToken(with code: String) -> AnyPublisher<String, Error> {
        return authClient.requestAccessToken(with: code).eraseToAnyPublisher()
    }
    
    func findAccessToken() -> AnyPublisher<String?, Error> {
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
