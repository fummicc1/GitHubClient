//
//  ProfileInteractor.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

final class ProfileInteractor<MyProfileClient: MyProfileRequestable, ProfileClient: ProfileRequestable> {
    
    init(profileClient: ProfileClient, myProfileClient: MyProfileClient) {
        self.profileClient = profileClient
        self.myProfileClient = myProfileClient
    }
    
    fileprivate let profileClient: ProfileClient
    fileprivate let myProfileClient: MyProfileClient
    
}

extension ProfileInteractor: GetMyProfileUseCase {
    func execute() -> AnyPublisher<Me, Error> {
        let query = MyProfileQuery(getFollowerCount: 50, getFolloweeCount: 100)
        
        return myProfileClient.fetch(query: query).map({ viewer in
            Me.from(response: viewer)
        }).eraseToAnyPublisher()
    }
}

extension ProfileInteractor: GetOtherProfileUseCase {
    func execute(of loginId: String) -> AnyPublisher<GitHubUser, Error> {
        let query = ProfileQuery(login: loginId)
        
        return profileClient.fetch(query: query).map({ user in
            GitHubUserModel.from(response: user)
        }).eraseToAnyPublisher()
    }
}
