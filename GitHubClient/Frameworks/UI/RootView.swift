//
//  RootView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI
import Swinject

struct RootView: View {
    
    @Environment(\.assembler) var assembler: Assembler
    
    @ObservedObject var viewModel: AppViewModel
    
    var destination: Destination {
        if let accessToken = viewModel.accessToken {
            return .main(accessToken: accessToken)
        }
        return .welcome
    }
    
    var body: some View {
        generateView(with: destination)
    }
}

extension RootView: Wireframe {
    
    enum Destination {
        case welcome
        case main(accessToken: String)
    }
    
    @ViewBuilder
    func generateView(with destination: Destination) -> some View {
        switch destination {
        case .welcome:
            WelcomeScreen(
                viewModel: assembler.resolver.resolve(WelcomeViewModel.self)!
            )
        case .main:
            TabView(selection: $viewModel.selectIndex,
                    content:  {
                        RepositoryListScreen(viewModel: assembler.resolver.resolve(RepositoryListViewModel.self)!
                        )
                        .tabItem { Text("Home") }
                        .tag(1)
                        
                        MyProfileScreen()
                            .tabItem { Text("Profile") }
                            .tag(2)
                    })
                .background(Color.clear)
        }
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let client = APIClient()
        let useCase = ProfileInteractor(
            userGateway: UserGateway(webClient: client),
            repoGateway: RepositoryGateway(webClient: client)
        )
        let authInteractor = GitHubOAuthInteractor(
            authGateway: AuthGateway(
                authClient: AuthClient(),
                graphQLClient: APIClient(),
                dataStore: DataStore()
            )
        )
        return RootView(
            viewModel: AppViewModel(
                profileUseCase: useCase,
                authUseCase: authInteractor
            )
        )
    }
}
