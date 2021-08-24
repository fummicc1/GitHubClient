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
    
    @Published var repositories: [GitHubRepositoryViewData] = []
    @Published var shouldShowErrorMessage: Bool = false
    @Published var errorMessage: ErrorMessageViewData?
    @Published var query: String = ""
    
    init(useCase: RepositoryUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetch(count: Int = 10) {
        useCase.search(with: query, count: count)
    }
}

extension RepositoryListViewModel: RepositoryUseCaseOutput {
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
                userName: repo.owner.login.id,
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
    }
    
    func didFailToSearch(error: Error) {
        let errorMessage = "エラー: \(error.localizedDescription)"
        self.errorMessage = ErrorMessageViewData(
            error: error,
            message: errorMessage
        )
    }
}
