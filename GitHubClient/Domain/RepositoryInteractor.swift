//
//  RepositoryInteractor.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine

class RepositoryInteractor
<SearchClient: SearchRepositoryRequestable, SpecificClient: SpecificRepositoryRequestable>
: GetRepositoryUseCase {
    
    private var pageIndex: Int = 1
    private var countPerPage: Int = 15
    
    init(
        searchClient: SearchClient,
        specificClient: SpecificClient
    ) {
        self.searchClient = searchClient
        self.specificClient = specificClient
    }
    
    private let searchClient: SearchClient
    private let specificClient: SpecificClient
    
    func execute(query: String) -> AnyPublisher<[Repository], Error> {
        let count = pageIndex * countPerPage
        let query = SearchRepositoryQuery(query: query, count: count)
        return searchClient.fetch(query: query)
            .map({ repositories in
                repositories.map({ repository in
                    Repository.from(repository: repository)
                })
            })
            .handleEvents(receiveCompletion: { _ in
                self.pageIndex += 1
            })
            .eraseToAnyPublisher()
    }
    
    func execute(owner: String, name: String) -> AnyPublisher<Repository, Error> {
        let query = SpecificRepositoryQuery(owner: owner, name: name)
        return specificClient.fetch(query: query)
            .map({ repository in
                Repository.from(repository: repository)
            })
            .eraseToAnyPublisher()
    }
}
