//
//  WebClientEnvironment.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/15.
//

import Foundation
import Apollo
import SwiftUI

struct WebClientKey: EnvironmentKey {
    static var defaultValue: WebClientProtocol {
        APIClient.make()
    }
}

// MARK: Values
extension EnvironmentValues {
    var webClient: WebClientProtocol {
        get {
            self[WebClientKey.self]
        }
        set {
            self[WebClientKey.self] = newValue
        }
    }
}
