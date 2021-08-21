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
            case didFindRepoList(repoList: GitHubRepositoryList)
            case didFindMe(MeEntity)
            case didOccureError(message: String)
        }
    }
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    func didOccureError(_ error: Error) {
        registerActual(.init(action: .didOccureError(message: error.localizedDescription)))
    }
    
    func didFind(me: MeEntity) {
        registerActual(.init(action: .didFindMe(me)))
    }
    
    func didFind(repoList: GitHubRepositoryList) {
        registerActual(.init(action: .didFindRepoList(repoList: repoList)))
    }
}
