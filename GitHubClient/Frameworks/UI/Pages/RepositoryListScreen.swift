//
//  RepositoryListScreen.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI
import SwiftUIX

struct RepositoryListScreen: View {
    
    var configuration: NavigationViewWithSearchBar.Configuration {
        .init(
            title: "Search List",
            prefersLargeTitle: true,
            searchBarPlaceholder: "Search"
        )
    }
    
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                RepositoryListView(repositories: $viewModel.repositories)
                Text(viewModel.repositories.isEmpty ? "未検索" : "\(viewModel.repositories.count)の検索結果")
                Spacer()
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
            .navigationTitle("Search Repository List")
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
        VStack {
            List {
                ForEach(repositories) { repository in
                    RepositoryCardView(repository: repository)
                }
            }
        }
    }
}
