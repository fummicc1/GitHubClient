//
//  AppViewModel.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/24.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var selectIndex: Int = 0
    @Published var me: MeViewData?
    @Published var error: ErrorMessageViewData?
    @Published var isLoggedIn: Bool = false
    
    private var profileUseCase: ProfileUseCaseProtocol!
    
    init(profileUseCase: ProfileUseCaseProtocol) {
        self.profileUseCase = profileUseCase
        profileUseCase.getMe()
            .map({ me in
                let viewData = MeViewData(
                    login: me.login.id,
                    avatarUrl: me.avatarUrl,
                    bio: me.bio,
                    followers: me.followers.map({ user in
                        GitHubUserViewData(
                            loginID: user.login.id,
                            avatarURL: user.avatarUrl
                        )
                    }),
                    followersCount: me.followers.count,
                    followees: me.followees.map({ user in
                        GitHubUserViewData(
                            loginID: user.login.id,
                            avatarURL: user.avatarUrl
                        )
                    }),
                    followeesCount: me.followees.count
                )
                return viewData
            })
            .map({ $0 as MeViewData? })
            .replaceError(with: nil)
            .assign(to: &$me)
        
        $me.map({ $0 != nil })
            .assign(to: &$isLoggedIn)
    }
}
