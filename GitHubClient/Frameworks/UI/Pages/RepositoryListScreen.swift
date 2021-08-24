//
//  RepositoryListScreen.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI
import SwiftUIX

struct RepositoryListScreen: View {
    
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                RepositoryListView(repositories: $viewModel.repositories)
                if viewModel.repositories.isEmpty {
                    VStack {
                        Spacer()
                        Text("\(viewModel.repositories.count)の検索結果")
                            .padding()
                            .background(Color.systemBackground)
                            .cornerRadius(8)
                            .shadow(x: 0, y: 2, blur: 8)
                        Spacer().frame(height: 24)
                    }
                }
            }
            .navigationSearchBar({
                SearchBar(
                    "Search Repository",
                    text: $viewModel.query,
                    onCommit: {
                        viewModel.fetch()
                    }
                )
            })
            .navigationTitle("Find")
        }
        .alert(isPresented: $viewModel.shouldShowErrorMessage) {
            let message = viewModel.errorMessage!
            return Alert(
                title: Text("エラーが発生しました"),
                message: Text(message.message),
                dismissButton: Alert.Button.default(Text("閉じる"), action: {
                    viewModel.errorMessage = nil
                    viewModel.shouldShowErrorMessage = false
                })
            )
        }
    }
}

struct RepositoryListView: View {
    
    @Binding var repositories: [GitHubRepositoryViewData]
    
    var body: some View {
        List {
            ForEach(repositories) { repository in
                RepositoryCardView(repository: repository)
            }
        }
    }
}

struct RepositoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let useCase = RepositoryInteractor(repositoryGateway: RepositoryGateway(webClient: APIClient.make()))
        
        let viewModel = RepositoryListViewModel(useCase: useCase)
        
        return RepositoryListScreen(viewModel: viewModel)
    }
}
