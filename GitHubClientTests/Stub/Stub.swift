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

// MARK: Foundation
extension Date: Stub {
    static func stub() -> Date {
        Date(timeIntervalSince1970: 0)
    }
}

// MARK: Entities
extension GitHubRepository: Stub {
    static func stub() -> GitHubRepository {
        let entity = GitHubRepository(
            id: GitHubRepositoryID(id: "MDEwOlJlcG9zaXRvcnkyODM2OTQ5MDA="),
            url: "https://github.com/fummicc1/fummicc1",
            createdAt: Date.stub(),
            description: "fummicc1 profile repository",
            isPrivate: false,
            name: "fummicc1",
            owner: GitHubUser.stub(),
            languages: [.stub()]
        )
        return entity
    }
}

extension GitHubRepository.Language: Stub {
    static func stub() -> GitHubRepository.Language {
        .init(name: "Swift", colorCode: "F05138")
    }
}

extension GitHubRepositoryList: Stub {
    static func stub() -> GitHubRepositoryList {
        GitHubRepositoryList(repositories: [.stub()])
    }
}

extension GitHubUser: Stub {
    static func stub() -> GitHubUser {
        GitHubUser(
            login: GitHubUserLoginID(id: "fummicc1"),
            avatarUrl: "https://avatars.githubusercontent.com/u/44002126?v=4"
        )
    }
    
    static func github() -> GitHubUser {
        GitHubUser(
            login: GitHubUserLoginID(id: "github"),
            avatarUrl: "https://avatars.githubusercontent.com/u/9919?s=200&v=4"
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
    
    static func github() -> MeEntity {
        MeEntity(
            login: GitHubUserLoginID(id: "github"),
            avatarUrl: "https://avatars.githubusercontent.com/u/9919?s=200&v=4",
            name: "Fumiya",
            bio: "iOS Engineer",
            followers: [],
            followersCount: 0,
            followees: [],
            followeesCount: 0
        )
    }
}

// MARK: ViewData
extension GitHubRepositoryViewData: Stub {
    static func stub() -> GitHubRepositoryViewData {
        GitHubRepositoryViewData(
            id: "fummicc1",
            userName: "fummicc1",
            avatarURL: "https://avatars.githubusercontent.com/u/44002126?v=4",
            name: "https://github.com/fummicc1/EasyFirebaseSwift",
            description: "An Easy Firebase (Auth / Firestore) Library written in Swift.",
            isPrivate: false,
            createDate: "2021/1/1",
            url: "https://github.com/fummicc1/EasyFirebaseSwift",
            languages: [.stub()],
            mostUsedLangauge: .stub()
        )
    }
}

extension GitHubRepositoryViewData.Language: Stub {
    static func stub() -> GitHubRepositoryViewData.Language {
        .init(name: "Swift", color: "F05138")
    }
}
