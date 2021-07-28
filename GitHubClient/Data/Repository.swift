//
//  Repository.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Apollo

struct Repository {
    let id: String
    let url: String
    let createdAt: Date
    let description: String?
    let isPrivate: Bool
    let name: String
    let owner: GitHubUser
}

extension Repository {
    static func from(repository: SearchRepositoryQuery.Data.Search.Edge.Node.AsRepository) {
        let ret = Repository(
            id: repository.id,
            url: repository.url,
            createdAt: repository.createdAt.convert(formatter: ISO8601DateFormatter()),
            description: repository.description,
            isPrivate: repository.isPrivate,
            name: repository.name,
            owner: GitHubUserModel.from(response: repository.owner)
        )
    }
}
