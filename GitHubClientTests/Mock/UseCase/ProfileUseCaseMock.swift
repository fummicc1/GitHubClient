//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
@testable import GitHubClient

class ProfileUseCaseMock: Mock, ProfileUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case getMe
            case get
        }
    }
    
    func getMe() {
        let function = Function(action: .getMe)
        registerActual(function)
    }
    
    func get(with id: GitHubUserLoginID) {
        let function = Function(action: .get)
        registerActual(function)
    }
    
}

class ProfileUseCaseOutputMock: Mock, ProfileUseCaseOutput {
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case didFindUser(GitHubUser)
            case didFindMe(MeEntity)
            case didOccureError
        }
    }
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    func didOccureError(_ error: Error) {
        registerActual(.init(action: .didOccureError))
    }
    
    func didFindMe(_ me: MeEntity) {
        registerActual(.init(action: .didFindMe(me)))
    }
    
    func didFindUser(_ user: GitHubUser) {
        registerActual(.init(action: .didFindUser(user)))
    }
}
