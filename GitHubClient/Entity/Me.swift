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
    
    let bio: String?
    
    let followers: [GitHubUser]
    let followersCount: Int
    
    let followees: [GitHubUser]
    let followeesCount: Int
}
