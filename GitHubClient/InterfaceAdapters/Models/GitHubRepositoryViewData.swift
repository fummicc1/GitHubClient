//
//  GitHubRepository.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

struct GitHubRepositoryViewData: Identifiable, Equatable {
    let id: String
    let userName: String
    let avatarURL: String
    let name: String
    let description: String?
    let isPrivate: Bool
    let createDate: String
    let url: String
}
