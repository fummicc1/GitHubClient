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
    
    private let apollo: ApolloClient
    
    private(set) var task: Apollo.Cancellable?
    
    init(apollo: ApolloClient) {
        self.apollo = apollo
    }
}

extension APIClient {
    static func make() -> APIClient {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let transport = RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: store),
            endpointURL: URL(string: "https://api.github.com/graphql")!,
            additionalHeaders: ["Authorization": "Bearer \(PrivateKey.gitHubAuthToken)"],
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false
        )
        let client = ApolloClient(
            networkTransport: transport,
            store: store
        )
        return APIClient(apollo: client)
    }
}

extension APIClient: WebClientProtocol {
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, Error> where Request : WebClientRequestable {
        if let task = task {
            task.cancel()
        }
        return Future { [weak self] promise in
            guard let self = self else {
                return
            }
            self.task = self.apollo.fetch(query: request.build(), resultHandler: { result in
                switch result {
                case .success(let response):
                    
                    if let errors = response.errors {
                        promise(.failure(ApiErrors.errors(errors)))
                        return
                    }
                    
                    let json = response.data.jsonValue
                    print(json)
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}
