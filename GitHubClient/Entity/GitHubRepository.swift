//
//  GitHubRepository.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Apollo

struct GitHubRepository {
    let id: GitHubRepositoryID
    let url: String
    let createdAt: Date
    let description: String?
    let isPrivate: Bool
    let name: String
    let owner: GitHubUser
}

struct GitHubRepositoryID: Equatable {
    let id: String
}

extension GitHubRepository: Equatable {
    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        lhs.id == rhs.id
    }
}

struct GitHubRepositoryList: Equatable {
    
    private(set) var repositories: [GitHubRepository]
    
    init(repositories: [GitHubRepository]) {
        self.repositories = repositories
    }
    
    mutating func append(repo: GitHubRepository) {
        repositories.append(repo)
    }
    
    subscript(id: GitHubRepositoryID) -> GitHubRepository? {
        repositories.first(where: { $0.id == id })
    }
}
