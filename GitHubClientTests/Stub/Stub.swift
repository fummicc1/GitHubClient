//
//  Stub.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import Foundation
@testable import GitHubClient

protocol Stub {
    static func stub() -> Self
}

// MARK: Entities
extension GitHubRepository: Stub {
    static func stub() -> GitHubRepository {
        let entity = GitHubRepository(
            id: GitHubRepositoryID(id: "MDEwOlJlcG9zaXRvcnkyODM2OTQ5MDA="),
            url: "https://github.com/fummicc1/fummicc1",
            createdAt: Date(),
            description: "fummicc1 profile repository",
            isPrivate: false,
            name: "fummicc1",
            owner: GitHubUser.stub()
        )
        return entity
    }
}

extension GitHubUser: Stub {
    static func stub() -> GitHubUser {
        GitHubUser(
            login: GitHubUserLoginID(id: "fummicc1"),
            avatarUrl: "https://avatars.githubusercontent.com/u/44002126?v=4"
        )
    }
}

extension MeEntity: Stub {
    static func stub() -> MeEntity {
        MeEntity(
            login: GitHubUserLoginID(id: "fummicc1"),
            avatarUrl: "https://avatars.githubusercontent.com/u/44002126?v=4",
            name: "Fumiya",
            bio: "iOS Engineer",
            followers: [],
            followersCount: 0,
            followees: [],
            followeesCount: 0
        )
    }
}
