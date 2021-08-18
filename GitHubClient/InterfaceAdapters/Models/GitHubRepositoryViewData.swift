//
//  GitHubRepository.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct GitHubRepositoryViewData: Identifiable {
    let id: String
    let userName: String
    let avatarURL: String
    let name: String
    let description: String?
    let isPrivate: Bool
    let createDate: String
    let url: String
}

extension GitHubRepositoryViewData {
    static func stub() -> GitHubRepositoryViewData {
        GitHubRepositoryViewData(
            id: "fummicc1",
            userName: "Fumiya",
            avatarURL: "https://avatars.githubusercontent.com/u/44002126?v=4",
            name: "https://github.com/fummicc1/EasyFirebaseSwift",
            description: "An Easy Firebase (Auth / Firestore) Library written in Swift.",
            isPrivate: false,
            createDate: "2021/1/1",
            url: "https://github.com/fummicc1/EasyFirebaseSwift"
        )
    }
}
