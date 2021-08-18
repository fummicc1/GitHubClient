//
//  RepositoryListScreen.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI

struct RepositoryListScreen: View, RepositoryListViewModelOutput {
    
    let viewModel: RepositoryListViewModelProtocol
    
    var configuration: NavigationViewWithSearchBar<RepositoryListView>.Configuration {
        .init(
            title: "Search List",
            prefersLargeTitle: true,
            searchBarPlaceholder: "Search"
        )
    }
    
    @State private var repositories: [GitHubRepositoryViewData] = []
    @State private var query: String = ""
    
    @State private var errorMessage: ErrorMessageViewData?
    
    var body: some View {
        NavigationViewWithSearchBar<RepositoryListView>(
            view: RepositoryListView(repositories: $repositories),
            configuration: configuration,
            onSearchChangeCommit: {
                viewModel.fetch(with: query)
            },
            searchText: $query
        )
        .ignoresSafeArea()
        .alert(item: $errorMessage) { message in
            Alert(
                title: Text("エラーは発生しました"),
                message: Text(message.message),
                dismissButton: Alert.Button.default(Text("閉じる"), action: {
                    errorMessage = nil
                })
            )

        }
    }
    
    func didUpdateRepositories(_ repositories: [GitHubRepositoryViewData]) {
        self.repositories = repositories
    }
    
    func showErrorMessage(_ message: ErrorMessageViewData) {
        
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
