//
//  Me.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

struct MeEntity {
    let login: GitHubUserLoginID
    let avatarUrl: String
    
    let name: String?
    let bio: String?
    
    let followers: [GitHubUser]
    let followersCount: Int
    
    let followees: [GitHubUser]
    let followeesCount: Int
}

extension MeEntity {
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
