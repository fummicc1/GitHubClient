//
//  APIClient.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
import Apollo

class APIClient {
    
    private var apollo: ApolloClient?
    
    private(set) var task: Apollo.Cancellable?
}

extension APIClient {
    private func build(accessToken: String) {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let transport = RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: store),
            endpointURL: URL(string: "https://api.github.com/graphql")!,
            additionalHeaders: ["Authorization": "Bearer \(accessToken)"],
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false
        )
        let client = ApolloClient(
            networkTransport: transport,
            store: store
        )
        self.apollo = client
    }
}

extension APIClient: GraphQLClientProtocol {
    
    func configure(accessToken: String?) {
        if let token = accessToken {
            build(accessToken: token)
        } else {
            apollo = nil
        }
    }
    
    func request<Request>(with request: Request) -> AnyPublisher<Request.Query.Data, Error> where Request : WebClientRequestable {
        if let task = task {
            task.cancel()
        }
        return Future { [weak self] promise in
            guard let self = self, let apollo = self.apollo else {
                return
            }
            self.task = apollo.fetch(query: request.build(), resultHandler: { result in
                switch result {
                case .success(let response):
                    
                    if let errors = response.errors {
                        promise(.failure(ApiErrors.errors(errors)))
                        return
                    }
                    
                    guard let data = response.data else {
                        return
                    }
                    
                    promise(.success(data))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}
