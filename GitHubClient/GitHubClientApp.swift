//
//  GitHubClientApp.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI
import Swinject

@main
struct GitHubClientApp: App {
    
    @Environment(\.assembler) var assembler: Assembler
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: assembler.resolver.resolve(AppViewModel.self)!)
        }
    }
}
