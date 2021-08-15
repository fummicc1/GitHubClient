//
//  RepositoryCardView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/08.
//

import SwiftUI

struct RepositoryCardView: View {
    
    let repository: Repository
    
    var body: some View {
        VStack {
            Spacer()
            Text(repository.name)
            Spacer()
        }
    }
}

struct RepositoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCardView(repository:
                            Repository(
                                id: "",
                                url: "https://github.com/fummicc1/fummicc1",
                                createdAt: Date(),
                                description: nil,
                                isPrivate: false,
                                name: "fummicc1",
                                owner: GitHubUserModel(
                                    login: "fummicc1",
                                    avatarUrl: ""
                                )
                                
                            )
        )
    }
}
