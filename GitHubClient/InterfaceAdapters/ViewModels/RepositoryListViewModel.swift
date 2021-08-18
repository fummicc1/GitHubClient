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
    func fetch(with query: String)
}

protocol RepositoryListViewModelOutput {
    func didUpdateRepositories(_ repositories: [GitHubRepositoryViewData])
    func showErrorMessage(_ message: ErrorMessageViewData)
}

final class RepositoryListViewModel: ObservableObject, RepositoryListViewModelProtocol {
    
    init(useCase: RepositoryUseCaseProtocol) {
        self.useCase = useCase
    }
    
    private var output: RepositoryListViewModelOutput!
    private weak var useCase: RepositoryUseCaseProtocol!
    
    func inject(output: RepositoryListViewModelOutput) {
        self.output = output
    }
    
    func fetch(with query: String) {
        useCase.search(with: query)
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
        output.didUpdateRepositories(reposViewData)
    }
    
    func didFailToSearch(error: Error) {
        let errorMessage = "エラー: \(error.localizedDescription)"
        output.showErrorMessage(ErrorMessageViewData(error: error, message: errorMessage))
    }
}
