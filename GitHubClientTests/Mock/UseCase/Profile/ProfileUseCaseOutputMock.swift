//
//  ProfileUseCaseOutputMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import XCTest
@testable import GitHubClient

class ProfileUseCaseOutputMock: DelegateMock, ProfileUseCaseOutput {
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case didFindRepoList(repoList: GitHubRepositoryList)
            case didFindMe(MeEntity)
            case didOccureError(message: String)
        }
    }
    
    var expectations: [Function.Action : XCTestExpectation] = [:]
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
    
    func relate(exp: XCTestExpectation, to action: Function.Action) {
        expectations[action] = exp
    }
}
