//
//  RepositoryUseCase.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine

protocol RepositoryUseCaseProtocol: AnyObject {
    func search(of owner: String, repoName: String)
    func search(with query: String)
}
