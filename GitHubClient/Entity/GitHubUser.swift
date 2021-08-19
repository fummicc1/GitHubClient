//
//  User.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

struct GitHubUserLoginID: Equatable {
    let id: String
}

struct GitHubUser {
    let login: GitHubUserLoginID
    let avatarUrl: String
}

extension GitHubUser {
    static func stub() -> GitHubUser {
        GitHubUser(
            login: GitHubUserLoginID(id: "fummicc1"),
            avatarUrl: "https://avatars.githubusercontent.com/u/44002126?v=4"
        )
    }
}
