//
//  Me.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

struct Me: GitHubUser {
    let login: String
    let avatarUrl: String
    
    let bio: String?
    
    let followers: [GitHubUser]
    let followersCount: Int
    
    let followees: [GitHubUser]
    let followeesCount: Int
}


extension Me {
    static func from(response: MyProfileQuery.Data.Viewer) -> Self {
        
        let followers = response
            .followers
            .nodes
            .flatMap({ nodes in
                nodes
                    .compactMap({ $0 })
                    .compactMap({ user in
                        GitHubUserModel(
                            login: user.login,
                            avatarUrl: user.avatarUrl
                        )
                    })
            }) ?? []
        
        let followees = response
            .following
            .nodes
            .flatMap({ nodes in
                nodes
                    .compactMap({ $0 })
                    .compactMap({ user in
                        GitHubUserModel(
                            login: user.login,
                            avatarUrl: user.avatarUrl
                        )
                    })
            }) ?? []
        
        return Me(
            login: response.login,
            avatarUrl: response.avatarUrl,
            bio: response.bio,
            followers: followers,
            followersCount: response.followers.totalCount,
            followees: followees,
            followeesCount: response.following.totalCount
        )
    }
}
