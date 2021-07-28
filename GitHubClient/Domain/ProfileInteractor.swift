//
//  ProfileInteractor.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

final class ProfileInteractor<Client: MyProfileRequestable> {
    
    init(profileClient: Client) {
        self.profileClient = profileClient
    }
    
    fileprivate let profileClient: Client
    
}

extension ProfileInteractor: GetMyProfileUseCase {
    func execute() -> AnyPublisher<Me, Error> {
        let query = MyProfileQuery(getFollowerCount: 50, getFolloweeCount: 100)
        
        return profileClient.fetch(query: query).map({ viewer in
            Me.from(response: viewer)
        }).eraseToAnyPublisher()
    }
}
