//
//  ProfileInteractorFake.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
@testable import GitHubClient

class ProfileInteractorFake: GetMyProfileUseCase {
    
    let requestable = MyProfileRequestableMock()
    
    func execute() -> AnyPublisher<Me, Error> {
        requestable
            .fetch(query: MyProfileQuery())
            .map { response in
                Me.from(response: response)
            }
            .eraseToAnyPublisher()
    }
}
