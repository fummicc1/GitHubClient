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
        
        enum Action {
            case searchSpecificRepository
            case searchWithQuery
        }
    }
    
    func search(of owner: String, repoName: String) {
        let f = Function(action: .searchSpecificRepository)
        registerActual(f)
    }
    
    func search(with query: String) {
        let f = Function(action: .searchWithQuery)
        registerActual(f)
    }
    
    
}
