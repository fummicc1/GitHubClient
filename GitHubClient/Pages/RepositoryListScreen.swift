//
//  RepositoryListScreen.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI

struct RepositoryListScreen: View {
    
    @ObservedObject var viewModel: RepositoryListViewModelImpl
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.repositories) { repository in
                        RepositoryCardView(repository: repository)
                    }
                }
            }.ignoresSafeArea()
            .navigationTitle("Search List")
        }
    }
}

struct RepositoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListScreen(viewModel: RepositoryListViewModelImpl(useCase: RepositoryInteractor(searchClient: SearchRepositoryApiClient(apollo: APIClient.gitHubClient), specificClient: SpecificRepositoryApiClient(apollo: APIClient.gitHubClient))))
    }
}
