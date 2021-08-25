//
//  GitHubOrganization.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/25.
//

import Foundation

struct GitHubOrganization: Hashable {
    let login: GitHubOrganizationLogin
    let avatarUrl: String
}

struct GitHubOrganizationLogin: Hashable {
    let value: String
}
