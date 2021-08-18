//
//  ProfileInteractor.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol UserGatewayProtocol {
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error>
    func fetchMe() -> AnyPublisher<MeEntity, Error>
}

final class ProfileInteractor {
    
    fileprivate var userGateway: UserGatewayProtocol!
    
    func inejct(userGateway: UserGatewayProtocol) {
        self.userGateway = userGateway
    }
}

extension ProfileInteractor: ProfileUseCaseProtocol {
    func getMe() -> AnyPublisher<MeEntity, Error> {
        return userGateway.fetchMe()
    }
    
    func get(with id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error> {
        return userGateway.fetch(id: id)
    }
}
