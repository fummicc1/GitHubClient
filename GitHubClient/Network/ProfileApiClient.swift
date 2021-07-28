//
//  ProfileApiClient.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
import SwiftUI
import Apollo

protocol ProfileRequestable: Requestable where Query == ProfileQuery, Response == ProfileQuery.Data.User {

}

final class ProfileApiClient: APIClient {
}

extension ProfileApiClient: ProfileRequestable {
    func fetch(query: ProfileQuery) -> AnyPublisher<ProfileQuery.Data.User, Error> {
        Future { [weak self] promise in
            self?.apollo.fetch(query: query, resultHandler: { result in
                switch result {
                case .success(let data):
                    
                    if let errors = data.errors {
                        promise(.failure(ApiErrors.errors(errors)))
                    }
                    
                    if let user = data.data?.user {
                        promise(.success(user))
                    }
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}
