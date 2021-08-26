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
    @State private var shouldHideSnackBar: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RepositoryListView(repositories: $viewModel.repositories)
                SnackBar(
                    text: $viewModel.snackBarTitle,
                    shouldShow: $viewModel.shouldShowSnackBar
                )
                .onChange(of: viewModel.shouldShowSnackBar, perform: { shouldShowSnackBar in
                    if shouldShowSnackBar {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.shouldShowSnackBar = false
                        }
                    }
                })
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
        .listStyle(InsetGroupedListStyle())
    }
}

struct RepositoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let useCase = RepositoryInteractor(
            repositoryGateway: RepositoryGateway(webClient: APIClient())
        )
        
        let viewModel = RepositoryListViewModel(useCase: useCase)
        
        return RepositoryListScreen(viewModel: viewModel)
    }
}
