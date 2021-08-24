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
    
//    @ViewBuilder
    var body: some View {
        
        if viewModel.isLoggedIn {
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
            Text("ログインしましょう")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let client = APIClient.make()
        let useCase = ProfileInteractor(
            userGateway: UserGateway(webClient: client),
            repoGateway: RepositoryGateway(webClient: client)
        )
        return RootView(viewModel: AppViewModel(profileUseCase: useCase))
    }
}
