//
//  MeViewData.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct MeViewData {
    let login: String
    let avatarUrl: String
    
    let bio: String?
    
    let followers: [GitHubUserViewData]
    let followersCount: Int
    
    let followees: [GitHubUserViewData]
    let followeesCount: Int
}
