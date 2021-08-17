//
//  RepositoryListScreen.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI

struct RepositoryListScreen: View {
    
    @StateObject var viewModel: RepositoryListViewModelImpl
    
    var configuration: NavigationViewWithSearchBar<RepositoryListView>.Configuration {
        .init(
            title: "Search List",
            prefersLargeTitle: true,
            searchBarPlaceholder: "Search"
        )
    }
    
    var body: some View {
        NavigationViewWithSearchBar<RepositoryListView>(
            view: RepositoryListView(viewModel: viewModel),
            configuration: configuration,
            onSearchChangeCommit: {
                viewModel.fetch()
            },
            searchText: $viewModel.query
        )
        .ignoresSafeArea()
    }
}

struct RepositoryListView: View {
    
    @ObservedObject var viewModel: RepositoryListViewModelImpl
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.repositories) { repository in
                    RepositoryCardView(repository: repository)
                }
            }
        }
    }
}

struct RepositoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListScreen(viewModel: RepositoryListViewModelImpl(useCase: RepositoryInteractor(searchClient: SearchRepositoryApiClient(apollo: APIClient.gitHubClient), specificClient: SpecificRepositoryApiClient(apollo: APIClient.gitHubClient))))
    }
}
