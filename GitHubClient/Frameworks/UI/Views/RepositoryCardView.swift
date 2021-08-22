//
//  RepositoryCardView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/08.
//

import SwiftUI

struct RepositoryCardView: View {
    
    let repository: GitHubRepositoryViewData
    
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
        RepositoryCardView(
            repository: GitHubRepositoryViewData(
                id: "fummicc1",
                userName: "fummicc1",
                avatarURL: "https://avatars.githubusercontent.com/u/44002126?v=4",
                name: "https://github.com/fummicc1/EasyFirebaseSwift",
                description: "An Easy Firebase (Auth / Firestore) Library written in Swift.",
                isPrivate: false,
                createDate: "2021/1/1",
                url: "https://github.com/fummicc1/EasyFirebaseSwift"
            )
        )
    }
}
