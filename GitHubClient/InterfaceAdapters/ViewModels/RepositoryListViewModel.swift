//
//  RepositoryListViewModel.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine
import SwiftUI

protocol RepositoryListViewModelProtocol {
    func fetch(count: Int)
}

final class RepositoryListViewModel: ObservableObject, RepositoryListViewModelProtocol {
    
    private var useCase: RepositoryUseCaseProtocol!
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var repositories: [GitHubRepositoryViewData] = []
    @Published var shouldShowErrorMessage: Bool = false
    @Published var errorMessage: ErrorMessageViewData?
    @Published var query: String = ""
    @Published var snackBarTitle: String = ""
    @Published var shouldShowSnackBar: Bool = false
    
    init(useCase: RepositoryUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetch(count: Int = 10) {
        useCase.search(with: query, count: count)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.didFailToSearch(error: error)
                }
            }) { repoList in
                self.didCompleteSearch(repositories: repoList)
            }
            .store(in: &cancellables)
    }
}

extension RepositoryListViewModel {
    func didCompleteSearch(repositories: GitHubRepositoryList) {
        let reposViewData = repositories.repositories.map({ repo -> GitHubRepositoryViewData in
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            
            let languages = repo.languages.map({ lang in
                GitHubRepositoryViewData.Language(name: lang.name, color: lang.colorCode)
            })
            
            return GitHubRepositoryViewData(
                id: repo.id.id,
                userName: repo.owner.loginID,
                avatarURL: repo.owner.avatarUrl,
                name: repo.name,
                description: repo.description,
                isPrivate: repo.isPrivate,
                createDate: formatter.string(from: repo.createdAt),
                url: repo.url,
                languages: languages,
                mostUsedLangauge: languages.first
            )
        })
        objectWillChange.send()
        self.repositories = reposViewData
        self.snackBarTitle = "\(reposViewData.count)件の検索結果"
        self.shouldShowSnackBar = true
    }
    
    func didFailToSearch(error: Error) {
        let errorMessage = "エラー: \(error.localizedDescription)"
        self.errorMessage = ErrorMessageViewData(
            error: error,
            message: errorMessage
        )
    }
}
