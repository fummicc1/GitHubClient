//
//  ProfileUseCaseOutputMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import Foundation
@testable import GitHubClient

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
