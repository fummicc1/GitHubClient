//
//  RepositoryListRouter.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/19.
//

import Foundation
import SwiftUI

struct RepositoryListRouterEnvironmentKey: EnvironmentKey {
    static var defaultValue: RepositoryListRouterProtocol {
        RepositoryListRouter()
    }
}

extension EnvironmentValues {
    var repositoryListRouter: RepositoryListRouterProtocol {
        get {
            self[RepositoryListRouterEnvironmentKey.self]
        }
        set {
            self[RepositoryListRouterEnvironmentKey.self] = newValue
        }
    }
}

protocol RepositoryListRouterProtocol {
    func assemble() -> RepositoryListScreen
}

class RepositoryListRouter: RepositoryListRouterProtocol {
    
    
    func assemble() -> RepositoryListScreen {
        let client = APIClient.make()
        let repositoryGateway = RepositoryGateway(webClient: client)
        
        let presenter = RepositoryListViewModel()
        
        let screen = RepositoryListScreen(viewModel: presenter)
        
        let useCase = RepositoryInteractor(
            repositoryGateway: repositoryGateway,
            output: presenter
        )
        
        presenter.inject(useCase: useCase)
        
        return screen
    }
}
