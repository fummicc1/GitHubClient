//
//  RepositoryListViewModel.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import Foundation
import Combine
import SwiftUI

protocol RepositoryListViewModel: ObservableObject {
    var repositories: [Repository] { get }
    func fetch(query: String)
}

final class RepositoryListViewModelImpl: ObservableObject, RepositoryListViewModel {
    
    @Published var repositories: [Repository] = []
    
    init(interactor: GetRepositoryUseCase) {
        self.interactor = interactor
    }
    
    private let interactor: GetRepositoryUseCase
    
    func fetch(query: String) {
        interactor.execute(query: query)
            .replaceError(with: [])
            .assign(to: &$repositories)
    }
}
