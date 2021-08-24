//
//  RepositoryUseCase.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine

protocol RepositoryUseCaseProtocol: AnyObject {
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error>
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error>
}
