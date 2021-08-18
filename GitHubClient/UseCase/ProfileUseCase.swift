//
//  ProfileUseCase.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol ProfileUseCaseProtocol: AnyObject {
    
    func getMe() -> AnyPublisher<MeEntity, Error>
    func get(with id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error>
}
