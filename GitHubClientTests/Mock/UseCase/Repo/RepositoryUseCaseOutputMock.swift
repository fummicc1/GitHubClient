//
//  RepositoryUseCaseOutputMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import XCTest
@testable import GitHubClient

class RepositoryUseCaseOutputMock: DelegateMock, RepositoryUseCaseOutput {
    
    var expected: [Function] = []
    var actual: [Function] = []
    var expectations: [Function.Action : XCTestExpectation] = [:]
    
    struct Function: MockFunction {
        
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case didCompleteSearch(GitHubRepositoryList)
            case didFail(errorMessage: String)
        }
    }
    
    func didCompleteSearch(repositories: GitHubRepositoryList) {
        registerActual(
            .init(
                action: .didCompleteSearch(repositories)
            )
        )
    }
    
    func didFailToSearch(error: Error) {
        registerActual(
            .init(
                action: .didFail(errorMessage: error.localizedDescription)
            )
        )
    }
    
    func relate(exp: XCTestExpectation, to action: Function.Action) {
        expectations[action] = exp
    }
}
