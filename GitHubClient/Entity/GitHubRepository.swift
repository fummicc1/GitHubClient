//
//  GitHubRepository.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Apollo

struct GitHubRepositoryOwner: Hashable {
    let loginID: String
    let avatarUrl: String
    let type: OwnerType
    
    enum OwnerType: String, Hashable {
        case org
        case user
    }
}

struct GitHubRepository {
    
    let id: GitHubRepositoryID
    let url: String
    let createdAt: Date
    let description: String?
    let isPrivate: Bool
    let name: String
    let org: GitHubOrganization?
    let user: GitHubUser?
    let languages: [Language]
    
    var owner: GitHubRepositoryOwner {
        if let org = org {
            return GitHubRepositoryOwner(
                loginID: org.login.value,
                avatarUrl: org.avatarUrl,
                type: .org
            )
        }
        if let user = user {
            return GitHubRepositoryOwner(
                loginID: user.login.id,
                avatarUrl: user.avatarUrl,
                type: .user
            )
        }
        fatalError()
    }
    
    init(
        id: GitHubRepositoryID,
        url: String,
        createdAt: Date,
        description: String?,
        isPrivate: Bool,
        name: String,
        org: GitHubOrganization?,
        user: GitHubUser?,
        languages: [Language]
    ) throws {
        
        if user == nil && org == nil {
            throw Error.ownerNotFound
        }
        
        self.id = id
        self.url = url
        self.createdAt = createdAt
        self.description = description
        self.isPrivate = isPrivate
        self.name = name
        self.org = org
        self.user = user
        self.languages = languages
    }
    
    static func makeWithISO8601DateFormatter(
        id: GitHubRepositoryID,
        url: String,
        createdAt: String,
        description: String?,
        isPrivate: Bool,
        name: String,
        org: GitHubOrganization?,
        user: GitHubUser?,
        languages: [Language]
    ) throws -> GitHubRepository {
        
        let dateFormatter = ISO8601DateFormatter()
        guard let createdAt = dateFormatter.date(from: createdAt) else {
            let error = Error.failedToFormatDate(text: createdAt)
            throw error
        }
        
        return try GitHubRepository(
            id: id,
            url: url,
            createdAt: createdAt,
            description: description,
            isPrivate: isPrivate,
            name: name,
            org: org,
            user: user,
            languages: languages
        )
    }
}

extension GitHubRepository {
    enum Error: Swift.Error {
        case failedToFormatDate(text: String)
        case ownerNotFound
    }
}

struct GitHubRepositoryID: Hashable {
    let id: String
    
    func validateLength() -> Bool {
        id.count == 32
    }
}

extension GitHubRepository: Hashable {
    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        lhs.id == rhs.id
    }
}

struct GitHubRepositoryList: Hashable {
    
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
    
    static let empty: Self = .init(repositories: [])
}

extension GitHubRepository {
    struct Language: Hashable {
        let name: String
        let colorCode: String?
    }
}
