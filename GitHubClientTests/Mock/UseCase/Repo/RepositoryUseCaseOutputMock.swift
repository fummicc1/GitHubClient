//
//  RepositoryUseCaseOutputMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import Foundation
@testable import GitHubClient

class RepositoryUseCaseOutputMock: Mock, RepositoryUseCaseOutput {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    struct Function: MockFunction {
        
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
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
    
}
