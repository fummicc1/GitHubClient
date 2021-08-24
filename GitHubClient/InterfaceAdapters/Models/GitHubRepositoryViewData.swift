//
//  GitHubRepository.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct GitHubRepositoryViewData: Identifiable, Hashable {
    let id: String
    let userName: String
    let avatarURL: String
    let name: String
    let description: String?
    let isPrivate: Bool
    let createDate: String
    let url: String
    let languages: [Language]
    let mostUsedLangauge: Language?
}

extension GitHubRepositoryViewData {
    struct Language: Identifiable, Hashable {
        let name: String
        let color: String?
        var hasColor: Bool {
            color != nil
        }
        
        var id: String {
            name
        }
    }
}
