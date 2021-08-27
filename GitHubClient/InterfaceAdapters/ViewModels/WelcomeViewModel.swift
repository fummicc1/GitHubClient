//
//  WelcomeViewModel.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/27.
//

import Foundation
import Combine

class WelcomeViewModel: ObservableObject {
    @Published var code: String?
    
    private let authUseCase: GitHubOAuthIUseCaseProtocol
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(authUseCase: GitHubOAuthIUseCaseProtocol) {
        self.authUseCase = authUseCase
        
        _code.projectedValue
            .compactMap({ $0 })
            .flatMap({ code in
                authUseCase.updateCode(code)
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellable)
    }
}

extension WelcomeViewModel {
}
