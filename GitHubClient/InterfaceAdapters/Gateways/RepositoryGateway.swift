//
//  RepositoryGateway.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
import Combine
import SwiftUI

struct SearchRepositoryRequestable: WebClientRequestable {
    
    typealias Query = SearchRepositoryQuery
    typealias Response = SearchRepositoryQuery.Data.Search
    
    let query: String
    let count: Int

    init(query: String, count: Int) {
        self.query = query
        self.count = count
    }
    
    func build() -> SearchRepositoryQuery {
        SearchRepositoryQuery(query: query, count: count)
    }
}

struct SpecificRepositoryRequestable: WebClientRequestable {
    typealias Query = SpecificRepositoryQuery
    typealias Response = SpecificRepositoryQuery.Data.Repository
    
    let owner: String
    let repoName: String
    
    func build() -> SpecificRepositoryQuery {
        SpecificRepositoryQuery(owner: owner, name: repoName)
    }
    
}

class RepositoryGateway: RepositoryGatewayProtocol {
    
    private var webClient: WebClientProtocol!
    
    internal init(webClient: WebClientProtocol) {
        self.webClient = webClient
    }
    
    func search(of owner: String, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
        let requestable = SpecificRepositoryRequestable(
            owner: owner,
            repoName: repoName
        )
        return webClient.request(with: requestable)
            .flatMap({ data -> Future<GitHubRepository, Error> in
                Future { promise in
                    
                    guard let repository = data.repository else {
                        promise(.failure(GatewayGenericError.failedToGetResult(data: data.resultMap)))
                        return
                    }
                    
                    do {
                        let entity = try GitHubRepository.makeWithISO8601DateFormatter(
                            id: GitHubRepositoryID(id: repository.id),
                            url: repository.url,
                            createdAt: repository.createdAt,
                            description: repository.description,
                            isPrivate: repository.isPrivate,
                            name: repository.name,
                            owner: GitHubUser(
                                login: GitHubUserLoginID(id: repository.owner.login),
                                avatarUrl: repository.owner.avatarUrl
                            )
                        )
                        promise(.success(entity))
                    } catch {
                        promise(.failure(error))
                    }
                }
            })
            .eraseToAnyPublisher()
    }
    
    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        let requestable = SearchRepositoryRequestable(query: query, count: count)
        return webClient.request(with: requestable)
            .flatMap { data -> Future<GitHubRepositoryList, Error> in
                
                let search = data.search
                
                let repositories = search.edges?
                    .compactMap({ edge -> SearchRepositoryQuery.Data.Search.Edge.Node.AsRepository? in
                        guard let edge = edge else {
                            return nil
                        }
                        return edge.node?.asRepository
                    }) ?? []
                
                return Future { promise in
                    do {
                        let entities = try repositories.map { repository in
                            try GitHubRepository.makeWithISO8601DateFormatter(
                                id: GitHubRepositoryID(id: repository.id),
                                url: repository.url,
                                createdAt: repository.createdAt,
                                description: repository.description,
                                isPrivate: repository.isPrivate,
                                name: repository.name,
                                owner: GitHubUser(
                                    login: GitHubUserLoginID(id: repository.owner.login),
                                    avatarUrl: repository.owner.avatarUrl
                                )
                            )
                        }
                        
                        let listEntity = GitHubRepositoryList(repositories: entities)
                        
                        promise(.success(listEntity))
                        
                    } catch {
                        promise(.failure(error))
                    }
                }
            }.eraseToAnyPublisher()
    }
}
