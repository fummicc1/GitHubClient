//
//  Me.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

struct MeEntity: Hashable {
    let login: GitHubUserLoginID
    let avatarUrl: String
    
    let name: String?
    let bio: String?
    
    let followers: [GitHubUser]
    let followersCount: Int
    
    let followees: [GitHubUser]
    let followeesCount: Int
}
