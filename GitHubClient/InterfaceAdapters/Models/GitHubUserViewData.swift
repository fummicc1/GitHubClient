//
//  User.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct GitHubUserViewData {
    let loginID: String
    let name: String
    let avatarURL: String
}

extension GitHubUserViewData: Identifiable {
    var id: String {
        loginID
    }
}
