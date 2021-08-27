//
//  WelcomeScreen.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @ObservedObject var viewModel: WelcomeViewModel
    
    var body: some View {
        return NavigationView {
            VStack {
            }
            .navigationBarTitle(Text("Welcome"), displayMode: .inline)
        }
        .sheet(isPresented: $viewModel.code.isNil(), content: {
            GitHubOAuthWebView(code: $viewModel.code)
        })
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(
            viewModel: WelcomeViewModel(
                authUseCase: GitHubOAuthInteractor(
                    authGateway: AuthGateway(
                        authClient: AuthClient(),
                        dataStore: DataStore()
                    )
                )
            )
        )
    }
}
