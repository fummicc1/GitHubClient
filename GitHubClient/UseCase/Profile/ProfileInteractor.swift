//
//  ProfileInteractor.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol UserGatewayProtocol: AutoMockable {
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error>
    func fetchMe(followerCount: Int, followeeCount: Int) -> AnyPublisher<MeEntity, Error>
}

final class ProfileInteractor {
    
    internal init(
        userGateway: UserGatewayProtocol,
        repoGateway: RepositoryGatewayProtocol,
        cancellables: Set<AnyCancellable> = Set()
    ) {
        self.userGateway = userGateway
        self.repoGateway = repoGateway
        self.cancellables = cancellables
    }
    
    private var userGateway: UserGatewayProtocol!
    private var repoGateway: RepositoryGatewayProtocol!
    
    private var cancellables: Set<AnyCancellable>
    
}

extension ProfileInteractor: ProfileUseCaseProtocol {
    
    enum Error: Swift.Error {
        case noGetResult
        case didNotFoundMe
    }
    
    static let defaultFetchCount: Int = 50
    
    func getMe() -> AnyPublisher<MeEntity, Swift.Error> {
        userGateway.fetchMe(
            followerCount: Self.defaultFetchCount,
            followeeCount: Self.defaultFetchCount
        )
    }
    
    func getMyRepoList() -> AnyPublisher<GitHubRepositoryList, Swift.Error> {
        
        let me = getMe()
        
        return me
            .map(\.login)
            .flatMap({ self.repoGateway.searchRepoList(of: $0) })
            .eraseToAnyPublisher()
    }
}
