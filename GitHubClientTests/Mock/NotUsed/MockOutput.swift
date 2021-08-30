//
//  MockOutput.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/22.
//

import Foundation

protocol MockOutput: AnyObject {
    associatedtype DTO
    
    /// Easy way to set value
    func set<V: Equatable, E: Swift.Error>(keyPath: WritableKeyPath<DTO, Result<V, E>>, value: Result<V, E>)
    
    var dto: DTO { get set }
}

extension MockOutput {
    func set<V, E>(keyPath: WritableKeyPath<DTO, Result<V, E>>, value: Result<V, E>) where V : Equatable, E : Error {
        dto[keyPath: keyPath] = value
    }
}
