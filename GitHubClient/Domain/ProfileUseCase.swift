//
//  ProfileUseCase.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol GetMyProfileUseCase {
    
    func execute() -> AnyPublisher<Me, Error>
}

protocol GetOtherProfileUseCase {
    func execute(of loginId: String) -> AnyPublisher<GitHubUser, Error>
}
