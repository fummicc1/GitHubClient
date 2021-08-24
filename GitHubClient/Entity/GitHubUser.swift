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
    
    let name: String?
    let bio: String?
    
    let detail: Detail?
}

extension GitHubUser {
    struct Detail: Hashable {
        let followers: [GitHubUser]
        let followesCount: Int
        
        let followees: [GitHubUser]
        let followeesCount: Int
    }
}
