//
//  RepositoryUseCaseMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import Foundation
@testable import GitHubClient

class RepositoryUseCaseMock: Mock, RepositoryUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    struct Function: MockFunction {
        
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case searchSpecificRepository(owner: String, repoName: String)
            case searchWithQuery(query: String, count: Int)
        }
    }
    
    func search(of owner: String, repoName: String) {
        let f = Function(
            action: .searchSpecificRepository(owner: owner, repoName: repoName)
        )
        registerActual(f)
    }
    
    func search(with query: String, count: Int) {
        let f = Function(
            action: .searchWithQuery(query: query, count: count)
        )
        registerActual(f)
    }
    
    
}
