//
//  NavigationViewWithSearchBar.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/17.
//

import Foundation
import SwiftUI
import UIKit

struct NavigationViewWithSearchBar: UIViewControllerRepresentable {
    
    let configuration: Configuration
    let onSearchChangeCommit: () -> Void
    
    @ObservedObject var viewModel: RepositoryListViewModel
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
        let navigationController = UINavigationController()
        
        navigationController.navigationBar.topItem?.title = configuration.title
        navigationController.navigationBar.prefersLargeTitles = configuration.prefersLargeTitle
        
        
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = context.coordinator
        searchController.searchBar.text = viewModel.query
        
        searchController.searchBar.placeholder = configuration.searchBarPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationController.navigationBar.topItem?.searchController = searchController
        navigationController.navigationBar.topItem?.hidesSearchBarWhenScrolling = true
        
        navigationController.navigationBar.sizeToFit()
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
}

extension NavigationViewWithSearchBar {
    class Coordinator: NSObject, UISearchBarDelegate {
        let parent: NavigationViewWithSearchBar
        
        init(parent: NavigationViewWithSearchBar) {
            self.parent = parent
            super.init()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.viewModel.query = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            parent.onSearchChangeCommit()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            guard let text = searchBar.text else {
                return
            }
            parent.viewModel.query = text
        }
    }
    
    struct Configuration {
        let title: String
        let prefersLargeTitle: Bool
        let searchBarPlaceholder: String?
    }
}
