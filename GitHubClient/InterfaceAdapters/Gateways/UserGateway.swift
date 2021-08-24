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
    func build() -> Query
}

protocol WebClientProtocol: AnyObject {
    func request<Request: WebClientRequestable>(with request: Request) -> AnyPublisher<Request.Query.Data, Error>
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
    
    let getFollowerCount: Int
    let getFolloweeCount: Int
    
    init(
        getFollowerCount: Int,
        getFolloweeCount: Int
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

enum GatewayGenericError: Swift.Error {
    case failedToGetResult(data: [String: Any?])
}

class UserGateway: UserGatewayProtocol {
    
    private var webClient: WebClientProtocol!
    
    internal init(webClient: WebClientProtocol) {
        self.webClient = webClient
    }
    
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error> {
        let request = UserRequestable(id: id.id)
        return webClient.request(with: request).flatMap({ data in
            Future<GitHubUser, Error> { promise in
                guard let queryUser = data.user else {
                    promise(.failure(GatewayGenericError.failedToGetResult(data: data.resultMap)))
                    return
                }
                let githubUser = GitHubUser(
                    login: GitHubUserLoginID(
                        id: queryUser.login
                    ),
                    avatarUrl: queryUser.avatarUrl
                )
                promise(.success(githubUser))
            }
        })
        .eraseToAnyPublisher()
    }
    
    func fetchMe(followerCount: Int, followeeCount: Int) -> AnyPublisher<MeEntity, Error> {
        let request = MeRequestable(
            getFollowerCount: followerCount,
            getFolloweeCount: followeeCount
        )
        return webClient.request(with: request).compactMap({ data in
            
            let me = data.viewer
            
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
                name: me.name,
                bio: me.bio,
                followers: followers,
                followersCount: me.followers.totalCount,
                followees: followees,
                followeesCount: me.following.totalCount
            )
        }).eraseToAnyPublisher()
    }
}
