//
//  RepositoryInteractor.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine

protocol RepositoryGatewayProtocol: AutoMockable {
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error>
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error>
    func searchRepoList(of id: GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error>
}

class RepositoryInteractor {
    
    init(
        repositoryGateway: RepositoryGatewayProtocol
    ) {
        self.repositoryGateway = repositoryGateway
    }
    
    private var repositoryGateway: RepositoryGatewayProtocol!
    
    private var cancellables: Set<AnyCancellable> = Set()
}

extension RepositoryInteractor: RepositoryUseCaseProtocol {
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
        return repositoryGateway.search(of: owner, repoName: repoName)
    }
    
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        return repositoryGateway.search(with: query, count: count)
    }
}
