//
//  RepositoryGatewayMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import Foundation
import Combine
@testable import GitHubClient

class RepositoryGatewayMock: Mock, MockOutput, RepositoryGatewayProtocol {
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case searchRepoListOfUser(userID: GitHubUserLoginID)
            case searchSpecificRepository(owner: GitHubUserLoginID, repoName: String)
            case searchWithQuery(query: String, count: Int)
        }
    }
    
    struct DTO {
        var searchRepoList: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
        var searchWithQuery: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
        var searchSpecific: Result<GitHubRepository, Error> = .failure(MockError.notConfigured)
    }
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var dto: DTO = .init()
    
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
            registerActual(
                .init(action: .searchSpecificRepository(owner: owner, repoName: repoName))
            )
        return dto.searchSpecific.publisher.eraseToAnyPublisher()
    }
    
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        registerActual(
            .init(action: .searchWithQuery(query: query, count: count))
        )
        return dto.searchWithQuery.publisher.eraseToAnyPublisher()
    }
    
    func searchRepoList(of id: GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error> {
        registerActual(.init(action: .searchRepoListOfUser(userID: id)))
        return dto.searchRepoList.publisher.eraseToAnyPublisher()
    }
}
