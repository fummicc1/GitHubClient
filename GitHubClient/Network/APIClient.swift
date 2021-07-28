//
//  APIClient.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
import Apollo

protocol Requestable {
    associatedtype Response
    associatedtype Query: GraphQLQuery
    func fetch(query: Query) -> AnyPublisher<Response, Error>
}

class APIClient {
    
    let apollo: ApolloClient
    
    var task: Apollo.Cancellable?
    
    init(apollo: ApolloClient) {
        self.apollo = apollo
    }
    
    static let gitHubClient: ApolloClient = {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let transport = RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: store),
            endpointURL: URL(string: "https://api.github.com/graphql")!,
            additionalHeaders: ["Authorization": "Bearer \(PrivateKey.gitHubAuthToken)"],
            autoPersistQueries: true,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false
        )
        let client = ApolloClient(
            networkTransport: transport,
            store: store
        )
        return client
    }()
}
