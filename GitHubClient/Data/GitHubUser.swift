//
//  User.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

protocol GitHubUser {
    var login: String { get }
    var avatarUrl: String { get }
}

struct GitHubUserModel: GitHubUser {
    let login: String
    let avatarUrl: String
}

extension GitHubUserModel {
    static func from(response: MyProfileQuery.Data.Viewer) -> Self {
        GitHubUserModel(login: response.login, avatarUrl: response.avatarUrl)
    }
    
    static func from(response: ProfileQuery.Data.User) -> Self {
        GitHubUserModel(login: response.login, avatarUrl: response.avatarUrl)
    }
    
    static func from(response: SearchRepositoryQuery.Data.Search.Edge.Node.AsRepository.Owner) -> Self {
        GitHubUserModel(login: response.login, avatarUrl: response.avatarUrl)
    }
    
    static func from(response: SpecificRepositoryQuery.Data.Repository.Owner) -> Self {
        GitHubUserModel(login: response.login, avatarUrl: response.avatarUrl)
    }
}
