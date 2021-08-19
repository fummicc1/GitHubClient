//
//  User.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct GitHubUserViewData {
    let loginID: String
    let avatarURL: String
}

extension GitHubUserViewData: Hashable, Identifiable {
    var id: String {
        loginID
    }
}
