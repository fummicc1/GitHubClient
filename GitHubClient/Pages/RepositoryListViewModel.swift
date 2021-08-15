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
    var query: String { get }
    func fetch(query: String)
}

final class RepositoryListViewModelImpl: ObservableObject, RepositoryListViewModel {
    
    @Published var repositories: [Repository] = []
    @Published var query: String = "fummicc1"
    
    init(useCase: GetRepositoryUseCase) {
        self.useCase = useCase
        fetch(query: query)
    }
    
    private let useCase: GetRepositoryUseCase
    
    func fetch(query: String) {
        useCase.execute(query: query)
            .replaceError(with: [])
            .assign(to: &$repositories)
    }
}
