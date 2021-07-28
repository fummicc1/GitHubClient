//
//  ProfileRequestableMock.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
@testable import GitHubClient

class ProfileRequestableMock: ProfileRequestable {
    
    var isCalledFetch: Bool = false
    var numberOfCall: Int = 0
    
    func fetch(query: ProfileQuery) -> AnyPublisher<ProfileQuery.Data.User, Error> {
        isCalledFetch = true
        numberOfCall += 1
        return Empty().eraseToAnyPublisher()
    }
}
