//
//  DIContainer.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/23.
//

import Foundation
import Swinject
import SwiftUI


// MARK: APIClient
class APIClientAssembly: Assembly {
    func assemble(container: Container) {
        assembleWebAPI(container: container)
    }
    
    private func assembleWebAPI(container: Container) {
        container.register(WebClientProtocol.self) { _ in
            APIClient.make()
        }
    }
}

// MARK: Gateway
class GatewayAssembly: Assembly {
    func assemble(container: Container) {
        userAssemble(container: container)
        repositoryAssemble(container: container)
    }
    
    private func userAssemble(container: Container) {
        container.register(UserGatewayProtocol.self) { resolver in
            let webClient = resolver.resolve(WebClientProtocol.self)!
            return UserGateway(webClient: webClient)
        }
    }
    
    private func repositoryAssemble(container: Container) {
        container.register(RepositoryGatewayProtocol.self) { resolver in
            let webClient = resolver.resolve(WebClientProtocol.self)!
            return RepositoryGateway(webClient: webClient)
        }
    }
}

// MARK: UseCase
class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        profileUseCase(container: container)
        repoUseCase(container: container)
    }
    
    private func profileUseCase(container: Container) {
        container.register(ProfileUseCaseProtocol.self) { resolver in
            ProfileInteractor(
                userGateway: resolver.resolve(UserGatewayProtocol.self)!,
                repoGateway: resolver.resolve(RepositoryGatewayProtocol.self)!
            )
        }
    }
    
    private func repoUseCase(container: Container) {
        container.register(RepositoryUseCaseProtocol.self) { resolver in
            RepositoryInteractor(
                repositoryGateway: resolver.resolve(RepositoryGatewayProtocol.self)!
            )
        }
    }
}

// MARK: ViewModels
class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        repositoryList(container: container)        
    }
    
    private func repositoryList(container: Container) {
        container.register(RepositoryListViewModel.self) { resolver in
            RepositoryListViewModel(useCase: resolver.resolve(RepositoryUseCaseProtocol.self)!)
        }.initCompleted { resolver, viewModel in
            if let interactor = resolver.resolve(RepositoryUseCaseProtocol.self) as? RepositoryInteractor {
                interactor.inject(output: viewModel)
            }
        }
    }
    
    private func myProfile(container: Container) {
        fatalError()
    }
}

struct DIContainer: EnvironmentKey {
    static var defaultValue: Assembler = Assembler([
        APIClientAssembly(),
        GatewayAssembly(),
        UseCaseAssembly(),
        ViewModelAssembly()
    ])
}

extension EnvironmentValues {
    var assembler: Assembler {
        get {
            self[DIContainer.self]
        }
        set {
            self[DIContainer.self] = newValue
        }
    }
}
