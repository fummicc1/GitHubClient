//
//  RepositoryUseCase.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine

protocol GetRepositoryUseCase {
    func execute(owner: String, name: String) -> AnyPublisher<Repository, Error>
    func execute(query: String) -> AnyPublisher<[Repository], Error>
}
