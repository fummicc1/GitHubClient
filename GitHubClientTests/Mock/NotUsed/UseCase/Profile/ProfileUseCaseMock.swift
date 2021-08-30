//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
import Combine
@testable import GitHubClient

class ProfileUseCaseMock: Mock, MockOutput, ProfileUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var dto: DTO = .init()
    
    func getMe() -> AnyPublisher<MeEntity, Error> {
        let function = Function(action: .getMe)
        registerActual(function)
        
        let response = dto.me
        return response.publisher.eraseToAnyPublisher()
    }
    
    func getMyRepoList() -> AnyPublisher<GitHubRepositoryList, Error> {
        let function = Function(action: .getMyRepoList)
        registerActual(function)
        
        let response = dto.myRepoList
        return response.publisher.eraseToAnyPublisher()
    }
}

extension ProfileUseCaseMock {
    struct DTO {
        var me:Result<MeEntity, Error> = .failure(MockError.notConfigured)
        var myRepoList: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
    }
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case getMe
            case getMyRepoList
        }
    }
}
