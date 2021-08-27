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
        webAPI(container: container)
        auth(container: container)
        dataStore(container: container)
    }
    
    private func webAPI(container: Container) {
        container.register(GraphQLClientProtocol.self) { _ in
            APIClient()
        }
        .inObjectScope(.container)
    }
    
    func auth(container: Container) {
        container.register(AuthClientProtocol.self) { _ in
            AuthClient()
        }
        .inObjectScope(.container)
    }
    
    func dataStore(container: Container) {
        container.register(DataStoreProtocol.self) { _ in
            DataStore()
        }
        .inObjectScope(.container)
    }
}

// MARK: Gateway
class GatewayAssembly: Assembly {
    func assemble(container: Container) {
        userAssemble(container: container)
        repositoryAssemble(container: container)
        authAssemble(container: container)
    }
    
    private func authAssemble(container: Container) {
        container.register(AuthGatewayProtocol.self) { resolver in
            AuthGateway(
                authClient: resolver.resolve(AuthClientProtocol.self)!,
                dataStore: resolver.resolve(DataStoreProtocol.self)!
            )
        }
    }
    
    private func userAssemble(container: Container) {
        container.register(UserGatewayProtocol.self) { resolver in
            let webClient = resolver.resolve(GraphQLClientProtocol.self)!
            return UserGateway(webClient: webClient)
        }
    }
    
    private func repositoryAssemble(container: Container) {
        container.register(RepositoryGatewayProtocol.self) { resolver in
            let webClient = resolver.resolve(GraphQLClientProtocol.self)!
            return RepositoryGateway(webClient: webClient)
        }
    }
}

// MARK: UseCase
class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        profileUseCase(container: container)
        repoUseCase(container: container)
        authUseCase(contaienr: container)
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
    
    private func authUseCase(contaienr: Container) {
        contaienr.register(GitHubOAuthIUseCaseProtocol.self) { resolver in
            GitHubOAuthInteractor(authGateway: resolver.resolve(AuthGatewayProtocol.self)!)
        }
    }
}

// MARK: ViewModels
class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        app(container: container)
        welcome(container: container)
        repositoryList(container: container)
        myProfile(container: container)
    }
    
    private func repositoryList(container: Container) {
        container.register(RepositoryListViewModel.self) { resolver in
            RepositoryListViewModel(useCase: resolver.resolve(RepositoryUseCaseProtocol.self)!)
        }
    }
    
    private func myProfile(container: Container) {
        container.register(MyProfileViewModel.self) { resolver in
            MyProfileViewModel(useCase: resolver.resolve(ProfileUseCaseProtocol.self)!)
        }
    }
    
    private func welcome(container: Container) {
        container.register(WelcomeViewModel.self) { resolver in
            WelcomeViewModel(authUseCase: resolver.resolve(GitHubOAuthIUseCaseProtocol.self)!)
        }
    }
    
    private func app(container: Container) {
        container.register(AppViewModel.self) { resolver in
            AppViewModel(
                profileUseCase: resolver.resolve(ProfileUseCaseProtocol.self)!,
                authUseCase: resolver.resolve(GitHubOAuthIUseCaseProtocol.self)!
            )
        }
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
