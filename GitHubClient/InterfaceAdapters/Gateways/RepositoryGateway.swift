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
    
    typealias Query = SearchQuery
    typealias Response = SearchQuery.Data.Search.Edge.Node.AsRepository
    
    let type: SearchType = .repository
    let query: String
    let count: Int

    init(query: String, count: Int) {
        self.query = query
        self.count = count
    }
    
    func build() -> SearchQuery {
        SearchQuery(query: query, type: type, count: count)
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

enum RepositoryGatewayError: Swift.Error {
    case failedToParse(data: [String: Any])
}

class RepositoryGateway: RepositoryGatewayProtocol {
    
    private var webClient: GraphQLClientProtocol!
    
    internal init(webClient: GraphQLClientProtocol) {
        self.webClient = webClient
    }
    
    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
        let requestable = SpecificRepositoryRequestable(
            owner: owner.id,
            repoName: repoName
        )
        return webClient.request(with: requestable)
            .flatMap({ data -> Future<GitHubRepository, Error> in
                Future { promise in
                    
                    guard let repository = data.repository else {
                        promise(
                            .failure(
                                GatewayGenericError.failedToGetResult(data: data.resultMap)
                            )
                        )
                        return
                    }
                    
                    do {
                        
                        let entity = try self.convertToEntity(repository: repository)
                        
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
                    .compactMap({ edge -> SearchQuery.Data.Search.Edge.Node.AsRepository? in
                        guard let edge = edge else {
                            return nil
                        }
                        return edge.node?.asRepository
                    }) ?? []
                
                return Future { promise in
                    do {
                        
                        let entities = try repositories.map({ repo in
                            try self.convertToEntity(repository: repo)
                        })
                        
                        let listEntity = GitHubRepositoryList(repositories: entities)
                        
                        promise(.success(listEntity))
                        
                    } catch {
                        promise(.failure(error))
                    }
                }
            }.eraseToAnyPublisher()
    }
    
    func searchRepoList(of id: GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error> {
        fatalError()
    }
}

extension RepositoryGateway {
    /// Helper method to parse response
    func convertToEntity(repository: SearchQuery.Data.Search.Edge.Node.AsRepository) throws -> GitHubRepository {
        let languages = repository.languages?.edges?
            .compactMap({ $0 })
            .map({ edge in
                GitHubRepository.Language(name: edge.node.name, colorCode: edge.node.color)
            }) ?? []
        
        
        var user: GitHubUser?
        var org: GitHubOrganization?
        
        ensureNonNil(value: repository.owner.asUser) { asUser in
            user = GitHubUser(
                login: GitHubUserLoginID(
                    id: asUser.login
                ),
                avatarUrl: asUser.avatarUrl
            )
        }
        
        ensureNonNil(value: repository.owner.asOrganization) { asOrg in
            org = GitHubOrganization(
                login: GitHubOrganizationLogin(value: asOrg.login),
                avatarUrl: asOrg.avatarUrl
            )
        }
        
        let entity = try GitHubRepository.makeWithISO8601DateFormatter(
            id: GitHubRepositoryID(id: repository.id),
            url: repository.url,
            createdAt: repository.createdAt,
            description: repository.description,
            isPrivate: repository.isPrivate,
            name: repository.repoName,
            org: org,
            user: user,
            languages: languages
        )
        return entity
    }
    
    func convertToEntity(repository: SpecificRepositoryQuery.Data.Repository) throws -> GitHubRepository {
        let languages = repository.languages?.edges?
            .compactMap({ $0 })
            .map({ edge in
                GitHubRepository.Language(
                    name: edge.node.name,
                    colorCode: edge.node.color
                )
            }) ?? []
        
        var user: GitHubUser?
        var org: GitHubOrganization?
        
        ensureNonNil(value: repository.owner.asUser) { asUser in
            user = GitHubUser(
                login: GitHubUserLoginID(
                    id: asUser.login
                ),
                avatarUrl: asUser.avatarUrl
            )
        }
        
        ensureNonNil(value: repository.owner.asOrganization) { asOrg in
            org = GitHubOrganization(
                login: GitHubOrganizationLogin(value: asOrg.login),
                avatarUrl: asOrg.avatarUrl
            )
        }
        
        let entity = try GitHubRepository.makeWithISO8601DateFormatter(
            id: GitHubRepositoryID(id: repository.id),
            url: repository.url,
            createdAt: repository.createdAt,
            description: repository.description,
            isPrivate: repository.isPrivate,
            name: repository.name,
            org: org,
            user: user,
            languages: languages
        )
        return entity
    }
}
