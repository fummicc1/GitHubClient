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
    
    var output: RepositoryUseCaseOutput!
    
    var dto: DTO = .init()
    
    struct Function: MockFunction {
        
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case searchSpecificRepository(owner: GitHubUserLoginID, repoName: String)
            case searchWithQuery(query: String, count: Int = 10)            
        }
    }
    
    func inject(output: RepositoryUseCaseOutput) {
        self.output = output
    }
    
    func search(with query: String, count: Int) {
        let f = Function(
            action: .searchWithQuery(query: query, count: count)
        )
        registerActual(f)
        
        let response = dto.searchWithQuery
        switch response {
        case .success(let data):
            output.didCompleteSearch(repositories: data)
        case .failure(let error):
            output.didFailToSearch(error: error)
        }
    }
    
    func search(of owner: GitHubUserLoginID, repoName: String) {
        let f = Function(
            action: .searchSpecificRepository(owner: owner, repoName: repoName)
        )
        registerActual(f)
        
        let response = dto.searchWithQuery
        switch response {
        case .success(let data):
            output.didCompleteSearch(repositories: data)
        case .failure(let error):
            output.didFailToSearch(error: error)
        }
    }
}

extension RepositoryUseCaseMock: MockOutput {
    struct DTO {
        var searchWithQuery: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
        var searchSpecific: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
    }
}
