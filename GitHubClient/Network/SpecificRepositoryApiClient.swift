//
//  RepositoryApiClient.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine
import SwiftUI
import Apollo

// MARK: SpecificRepositoryRequestable
protocol SpecificRepositoryRequestable: Requestable where Response == SpecificRepositoryQuery.Data.Repository, Query == SpecificRepositoryQuery {
}

final class SpecificRepositoryApiClient: APIClient {
}

extension SpecificRepositoryApiClient: SpecificRepositoryRequestable {
    func fetch(query: SpecificRepositoryQuery) -> AnyPublisher<SpecificRepositoryQuery.Data.Repository, Error> {
        Future { [weak self] promise in
            self?.apollo.fetch(query: query, resultHandler: { result in
                switch result {
                case .success(let data):
                    
                    if let errors = data.errors {
                        promise(.failure(ApiErrors.errors(errors)))
                    }
                    
                    if let repo = data.data?.repository {
                        promise(.success(repo))
                    }
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}

// MARK: SearchRepositoryRequestable
protocol SearchRepositoryRequestable: Requestable where Response == [SearchRepositoryQuery.Data.Search.Edge.Node.AsRepository], Query == SearchRepositoryQuery {
    
}

final class SearchRepositoryApiClient: APIClient {
    
}

extension SearchRepositoryApiClient: SearchRepositoryRequestable {
    func fetch(query: SearchRepositoryQuery) -> AnyPublisher<[SearchRepositoryQuery.Data.Search.Edge.Node.AsRepository], Error> {
        Future { [weak self] promise in
            self?.apollo.fetch(query: query, resultHandler: { result in
                switch result {
                case .success(let data):
                    
                    if let errors = data.errors {
                        promise(.failure(ApiErrors.errors(errors)))
                    }
                    
                    if let edges = data.data?.search.edges {
                        let repositories = edges.compactMap({ $0?.node?.asRepository })
                        promise(.success(repositories))
                    }
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}
