//
//  User.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

struct GitHubUserLoginID: Hashable {
    let id: String
}

struct GitHubUser: Hashable {
    let login: GitHubUserLoginID
    let avatarUrl: String
}
