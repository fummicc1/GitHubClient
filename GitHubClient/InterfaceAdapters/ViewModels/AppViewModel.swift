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
    @Published var error: ErrorMessageViewData?
    @Published var accessToken: String?
    
    private var profileUseCase: ProfileUseCaseProtocol!
    private var authUseCase: GitHubOAuthIUseCaseProtocol!
    
    init(profileUseCase: ProfileUseCaseProtocol, authUseCase: GitHubOAuthIUseCaseProtocol) {
        self.profileUseCase = profileUseCase
        self.authUseCase = authUseCase
        
        authUseCase.onAccessToken()
            .map({ $0 as String? })
            .replaceError(with: nil)
            .assign(to: &$accessToken)
    }
    
    private func updateAccessTokenStatus() {
        authUseCase.getAccessToken()
            .replaceError(with: nil)
            .assign(to: &$accessToken)
    }
}
