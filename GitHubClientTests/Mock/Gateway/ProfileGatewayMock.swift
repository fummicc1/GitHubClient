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
        
        enum Action: Hashable {
            case fetchWithID(GitHubUserLoginID)
            case fetchMe
        }
    }
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var dto: DTO = .init()
    
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error> {
        registerActual(.init(action: .fetchWithID(id)))
        return dto.withID.publisher.eraseToAnyPublisher()
    }
    
    func fetchMe() -> AnyPublisher<MeEntity, Error> {
        registerActual(.init(action: .fetchMe))
        return dto.me.publisher.eraseToAnyPublisher()
    }
}

extension ProfileGatewayMock: MockOutput {
    
    struct DTO {
        var withID: Result<GitHubUser, Error> = .failure(MockError.notConfigured)
        var me: Result<MeEntity, Error> = .failure(MockError.notConfigured)
    }
}
