//
//  ApiErrors.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation

enum ApiErrors: Error {
    case errors([Error])
}
