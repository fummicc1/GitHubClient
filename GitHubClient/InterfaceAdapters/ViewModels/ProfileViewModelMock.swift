//
//  ProfileViewModelMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

protocol ProfileViewModelProtocol {
}

protocol ProfileViewModelOutput {
    func didUpdateMe(_ me: MeViewData)
    func showErrorMessage(_ message: ErrorMessageViewData)
    
}

class ProfileViewModel: ObservableObject, ProfileViewModelProtocol {
}

extension ProfileViewModel: ProfileUseCaseOutput {
    func didFindUser(_ user: GitHubUser) {
    }
    
    func didFindMe(_ me: MeEntity) {
        let meViewData = MeViewData(
            login: me.login.id,
            avatarUrl: me.avatarUrl,
            bio: me.bio,
            followers: me.followers.map({ user in
                GitHubUserViewData(
                    loginID: user.login.id,
                    avatarURL: user.avatarUrl
                )
            }),
            followersCount: me.followersCount,
            followees: me.followees.map({ user in
                GitHubUserViewData(
                    loginID: user.login.id,
                    avatarURL: user.avatarUrl
                )
            }),
            followeesCount: me.followersCount
        )
        didUpdateMe(meViewData)
    }
    
    func didOccureError(_ error: Error) {
        let errorMessage = ErrorMessageViewData(
            error: error,
            message: "エラー: \(error.localizedDescription)"
        )
        showErrorMessage(errorMessage)
    }
}

extension ProfileViewModel: ProfileViewModelOutput {
    func didUpdateMe(_ me: MeViewData) {
        
    }
    
    func showErrorMessage(_ message: ErrorMessageViewData) {
        
    }
    
    
}
