//
//  UserGateway.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
import Combine
import Apollo

protocol WebClientRequestable {
    associatedtype Query: GraphQLQuery
    associatedtype Response
    func build() -> Query
}

protocol WebClientProtocol {
    func request<Request: WebClientRequestable>(with request: Request) -> AnyPublisher<Request.Response, Error>
}

struct UserRequestable: WebClientRequestable {
    typealias Query = ProfileQuery
    typealias Response = ProfileQuery.Data.User
    
    let id: String
    
    func build() -> ProfileQuery {
        ProfileQuery(login: id)
    }
}

struct MeRequestable: WebClientRequestable {
    
    typealias Query = MyProfileQuery
    typealias Response = MyProfileQuery.Data.Viewer
    
    let getFollowerCount: Int?
    let getFolloweeCount: Int?
    
    init(
        getFollowerCount: Int? = nil,
        getFolloweeCount: Int? = nil
    ) {
        self.getFollowerCount = getFollowerCount
        self.getFolloweeCount = getFolloweeCount
    }
    
    func build() -> MyProfileQuery {
        MyProfileQuery(
            getFollowerCount: getFollowerCount,
            getFolloweeCount: getFolloweeCount
        )
    }
}

class UserGateway: UserGatewayProtocol {
    
    private weak var useCase: ProfileUseCaseProtocol!
    private var webClient: WebClientProtocol!
    
    init(
        useCase: ProfileUseCaseProtocol?
    ) {
        self.useCase = useCase
    }
    
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error> {
        let request = UserRequestable(id: id.id)
        return webClient.request(with: request).map({ user in
            GitHubUser(
                login: GitHubUserLoginID(
                    id: user.login
                ),
                avatarUrl: user.avatarUrl
            )
        }).eraseToAnyPublisher()
    }
    
    func fetchMe() -> AnyPublisher<MeEntity, Error> {
        let request = MeRequestable()
        return webClient.request(with: request).map({ me in
            
            let followers = me.followers.nodes?
                .compactMap({ $0 })
                .map({ node in
                        GitHubUser(
                            login: GitHubUserLoginID(id: node.login),
                            avatarUrl: node.avatarUrl
                        )
                }) ?? []
            
            let followees = me.following.nodes?
                .compactMap({ $0 })
                .map({ node in
                    GitHubUser(
                        login: GitHubUserLoginID(id: node.login),
                        avatarUrl: node.avatarUrl
                    )
                }) ?? []
            
            return MeEntity(
                login: GitHubUserLoginID(id: me.login),
                avatarUrl: me.avatarUrl,
                bio: me.bio,
                followers: followers,
                followersCount: me.followers.totalCount,
                followees: followees,
                followeesCount: me.following.totalCount
            )
        }).eraseToAnyPublisher()
    }
    
}
