//
//  RepositoryInteractor.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine

protocol RepositoryUseCaseOutput {
    func didCompleteSearch(repositories: GitHubRepositoryList)
    func didFailToSearch(error: Error)
}

protocol RepositoryGatewayProtocol {
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error>
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error>
    func searchRepoList(of id: GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error>
}

class RepositoryInteractor {
    
    init(
        repositoryGateway: RepositoryGatewayProtocol?,
        output: RepositoryUseCaseOutput?
    ) {
        self.repositoryGateway = repositoryGateway
        self.output = output
    }
    
    
    private var repositoryGateway: RepositoryGatewayProtocol!
    private var output: RepositoryUseCaseOutput!
    
    private var cancellables: Set<AnyCancellable> = Set()
}

extension RepositoryInteractor: RepositoryUseCaseProtocol {
    func search(of owner: GitHubUserLoginID, repoName: String) {
        var repositories = GitHubRepositoryList(repositories: [])
        repositoryGateway.search(of: owner, repoName: repoName)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.output.didCompleteSearch(repositories: repositories)
                    
                case .failure(let error):
                    self?.output.didFailToSearch(error: error)
                }
            } receiveValue: { repository in
                repositories.append(repo: repository)
            }
            .store(in: &cancellables)

    }
    
    func search(with query: String, count: Int) {
        var repositories: GitHubRepositoryList = GitHubRepositoryList(repositories: [])
        repositoryGateway.search(with: query, count: count)
            .sink { [weak self] completion in
                
                switch completion {
                case .finished:
                    self?.output.didCompleteSearch(repositories: repositories)
                case .failure(let error):
                    self?.output.didFailToSearch(error: error)
                }
                
            } receiveValue: { repositoryList in
                repositories = repositoryList
            }
            .store(in: &cancellables)

    }
}
