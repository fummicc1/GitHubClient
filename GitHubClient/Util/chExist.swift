//
//  chExist.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/25.
//

import Foundation

func chNonNil<V>(base: inout Optional<V>, value: Optional<V>) {
    if let value = value {
        base = value
    }
}

func ensureNonNil<V>(value: Optional<V>, handler: @escaping (V) -> Void) {
    if let value = value {
        handler(value)
    }
}
