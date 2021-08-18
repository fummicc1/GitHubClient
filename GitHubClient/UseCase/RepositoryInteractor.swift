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
    func search(of owner: String, repoName: String) -> AnyPublisher<GitHubRepository, Error>
    func search(with words: [String]) -> AnyPublisher<GitHubRepositoryList, Error>
    func search(with query: String) -> AnyPublisher<GitHubRepositoryList, Error>
}

class RepositoryUseCase {
    
    private var repositoryGateway: RepositoryGatewayProtocol!
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    private var output: RepositoryUseCaseOutput!
    
    func inject(output: RepositoryUseCaseOutput, gateway: RepositoryGatewayProtocol) {
        self.output = output
        self.repositoryGateway = gateway
    }
}

extension RepositoryUseCase: RepositoryUseCaseProtocol {
    func search(of owner: String, repoName: String) {
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
    
    func search(with query: String) {
        var repositories: GitHubRepositoryList = GitHubRepositoryList(repositories: [])
        repositoryGateway.search(with: query)
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
