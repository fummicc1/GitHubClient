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

struct GitHubUser: Equatable {
    let login: GitHubUserLoginID
    let avatarUrl: String
}
