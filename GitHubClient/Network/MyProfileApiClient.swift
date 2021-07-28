//
//  MyProfileApiClient.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
import SwiftUI
import Apollo

protocol MyProfileRequestable: Requestable where Query == MyProfileQuery, Response == MyProfileQuery.Data.Viewer {

}

final class MyProfileApiClient: APIClient {
}

extension MyProfileApiClient: MyProfileRequestable {
    
    func fetch(query: MyProfileQuery) -> AnyPublisher<MyProfileQuery.Data.Viewer, Error> {
        Future { [weak self] promise in
            self?.apollo.fetch(query: query) { result in
                switch result {
                case .success(let data):
                    if let viewer = data.data?.viewer {
                        promise(.success(viewer))
                    }
                    
                    if let errors = data.errors {
                        let error = ApiErrors.errors(errors)
                        promise(.failure(error))
                    }
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
