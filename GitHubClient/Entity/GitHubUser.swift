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
    
    let followers: [GitHubUser]?
    let followesCount: Int?
    
    let followees: [GitHubUser]?
    let followeesCount: Int?
    
    internal init(
        login: GitHubUserLoginID,
        avatarUrl: String,
        name: String? = nil,
        bio: String? = nil,
        followers: [GitHubUser]? = nil,
        followesCount: Int? = nil,
        followees: [GitHubUser]? = nil,
        followeesCount: Int? = nil
    ) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.bio = bio
        self.followers = followers
        self.followesCount = followesCount
        self.followees = followees
        self.followeesCount = followeesCount
    }
    
}
