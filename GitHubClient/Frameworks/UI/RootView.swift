//
//  RootView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import SwiftUI
import Swinject

struct RootView: View {
    
    @State private var selectIndex: Int = 0
    
    @Environment(\.assembler) var assembler: Assembler
    
    var body: some View {
        TabView(selection: $selectIndex,
                content:  {
                    RepositoryListScreen(viewModel: assembler.resolver.resolve(RepositoryListViewModel.self)!)
                    .tabItem { Text("Tab Label 1") }
                    .tag(1)
                    
                    Text("Tab Content 2")
                        .tabItem { Text("Tab Label 2") }
                        .tag(2)
                })
            .background(Color.clear)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
