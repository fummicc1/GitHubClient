//
//  RepositoryUseCaseMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import Foundation
import Combine
@testable import GitHubClient

class RepositoryUseCaseMock: Mock, RepositoryUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var dto: DTO = .init()
    
    struct Function: MockFunction {
        
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case searchSpecificRepository(owner: GitHubUserLoginID, repoName: String)
            case searchWithQuery(query: String, count: Int = 10)            
        }
    }
    
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
        let f = Function(
            action: .searchSpecificRepository(owner: owner, repoName: repoName)
        )
        registerActual(f)
        
        let response = dto.searchSpecific
        return response.publisher.eraseToAnyPublisher()
    }
    
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        let f = Function(
            action: .searchWithQuery(query: query, count: count)
        )
        registerActual(f)
        
        let response = dto.searchWithQuery
        return response.publisher.eraseToAnyPublisher()
    }
}

extension RepositoryUseCaseMock: MockOutput {
    struct DTO {
        var searchWithQuery: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
        var searchSpecific: Result<GitHubRepository, Error> = .failure(MockError.notConfigured)
    }
}
