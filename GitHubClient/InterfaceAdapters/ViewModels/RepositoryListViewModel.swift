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
    func fetch()
}

protocol RepositoryListViewModelOutput {
    func didUpdateRepositories(_ repositories: [GitHubRepositoryViewData])
    func showErrorMessage(_ message: ErrorMessageViewData)
}

final class RepositoryListViewModel: ObservableObject, RepositoryListViewModelProtocol {
    
    private var useCase: RepositoryUseCaseProtocol!
    
    @Published var repositories: [GitHubRepositoryViewData] = [GitHubRepositoryViewData.stub()]
    @Published var shouldShowErrorMessage: Bool = false
    @Published var errorMessage: ErrorMessageViewData?
    @Published var query: String = ""
    
    private let searchCount: Int = 10
    
    func inject(useCase: RepositoryUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetch() {
        useCase.search(with: query, count: searchCount)
    }
}

extension RepositoryListViewModel: RepositoryUseCaseOutput {
    func didCompleteSearch(repositories: GitHubRepositoryList) {
        let reposViewData = repositories.repositories.map({ repo -> GitHubRepositoryViewData in
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            
            return GitHubRepositoryViewData(
                id: repo.id.id,
                userName: repo.owner.login.id,
                avatarURL: repo.owner.avatarUrl,
                name: repo.name,
                description: repo.description,
                isPrivate: repo.isPrivate,
                createDate: formatter.string(from: repo.createdAt),
                url: repo.url
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
