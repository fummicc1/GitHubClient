//
//  ProfileViewModelMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

protocol ProfileViewModelProtocol {
    func findMe()
    func findMyRepoList()
}

class ProfileViewModel: ObservableObject, ProfileViewModelProtocol {
    
    @Published var me: MeViewData?
    @Published var error: ErrorMessageViewData?
    
    private var useCase: ProfileUseCaseProtocol!
    
    func inject(useCase: ProfileUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func findMyRepoList() {        
        useCase.getMyRepoList()
    }
    
    func findMe() {
        useCase.getMe()
    }
    
}

extension ProfileViewModel: ProfileUseCaseOutput {
    
    func didFind(repoList: GitHubRepositoryList) {
        fatalError()
    }
    
    func didFind(me: MeEntity) {
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
        self.me = meViewData
    }
    
    func didOccureError(_ error: Swift.Error) {
        let errorMessage = ErrorMessageViewData(
            error: error,
            message: "エラー: \(error.localizedDescription)"
        )
        self.error = errorMessage
    }
}

extension ProfileViewModel {
    enum Error: Swift.Error {
        case didNotFoundMe
    }
}
