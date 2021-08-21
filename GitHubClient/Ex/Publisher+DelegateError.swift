//
//  Publisher+DelegateError.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import Foundation
import Combine

extension Publisher {
    func delegateError<S: Subject>(to errorSubject: S) -> AnyPublisher<Self.Output, Never> where S.Output == Swift.Error {
        self.catch { error -> Empty<Output, Never> in
            errorSubject.send(error)
            return Empty<Output, Never>()
        }.eraseToAnyPublisher()
    }
}
