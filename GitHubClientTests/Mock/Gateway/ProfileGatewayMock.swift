//
//  ProfileGatewayMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import Foundation
import Combine
@testable import GitHubClient

class ProfileGatewayMock: Mock, UserGatewayProtocol {
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case fetchWithID(GitHubUserLoginID)
            case fetchMe
        }
    }
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var fetchWithIDResponse: Result<GitHubUser, Error> = .failure(GatewayMockError.notConfigured)
    
    var fetchMeResponse: Result<MeEntity, Error> = .failure(GatewayMockError.notConfigured)
    
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error> {
        registerActual(.init(action: .fetchWithID(id)))
        return fetchWithIDResponse.publisher.eraseToAnyPublisher()
    }
    
    func fetchMe() -> AnyPublisher<MeEntity, Error> {
        registerActual(.init(action: .fetchMe))
        return fetchMeResponse.publisher.eraseToAnyPublisher()
    }
}
