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
    
    var body: some View {
        if viewModel.accessToken != nil {
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
        } else {
            WelcomeScreen(
                viewModel: assembler.resolver.resolve(WelcomeViewModel.self)!
            )
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
