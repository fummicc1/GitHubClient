//
//  RepositoryGatewayMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import Foundation
import Combine
@testable import GitHubClient

class RepositoryGatewayMock: Mock, RepositoryGatewayProtocol {
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case searchRepoListOfUser(userID: GitHubUserLoginID)
            case searchSpecificRepository(owner: GitHubUserLoginID, repoName: String)
            case searchWithQuery(query: String, count: Int)
        }
    }
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var searchSpecificResponse: Result<GitHubRepository, Error> = .failure(GatewayMockError.notConfigured)
    var searchWithQueryResponse: Result<GitHubRepositoryList, Error> = .failure(GatewayMockError.notConfigured)
    var searchRepoListResponse: Result<GitHubRepositoryList, Error> = .failure(GatewayMockError.notConfigured)
    
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
            registerActual(
                .init(action: .searchSpecificRepository(owner: owner, repoName: repoName))
            )
            return searchSpecificResponse.publisher.eraseToAnyPublisher()
    }
    
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        registerActual(
            .init(action: .searchWithQuery(query: query, count: count))
        )
        return searchWithQueryResponse.publisher.eraseToAnyPublisher()
    }
    
    func searchRepoList(of id: GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error> {
        registerActual(.init(action: .searchRepoListOfUser(userID: id)))
        return searchRepoListResponse.publisher.eraseToAnyPublisher()
    }
}
