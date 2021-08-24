//
//  RepositoryCardView.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/08.
//

import SwiftUI

struct RepositoryCardView: View {
    
    let repository: GitHubRepositoryViewData
    let imageSize: CGSize = CGSize(width: 44, height: 44)
    
    var body: some View {
        VStack {
            HStack {
                NetworkImage(url: repository.avatarURL, size: imageSize)
                    .border(
                        Color.gray,
                        width: 1,
                        cornerRadius: 4,
                        style: .continuous
                    )
                Text(repository.userName)
                Spacer()
            }
            Spacer().frame(height: 8)
            HStack(alignment: .bottom) {
                Text(repository.name)
                    .bold()
                Spacer()
            }
            if let description = repository.description {
                Spacer().frame(height: 8)
                HStack {
                    Text(description)
                    Spacer()
                }
            }
            Spacer().frame(height: 8)
            VStack {
                HStack {
                    if let mostUsedLang = repository.mostUsedLangauge {
                        Color(hexadecimal: mostUsedLang.color ?? "#ffffff")
                            .frame(width: 16, height: 16)
                            .clipShape(Circle())
                        Text(mostUsedLang.name)
                    }
                    Spacer()
                }
            }
        }
        .padding(12)
    }
}

struct RepositoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCardView(
            repository: GitHubRepositoryViewData(
                id: "fummicc1",
                userName: "fummicc1",
                avatarURL: "https://avatars.githubusercontent.com/u/44002126?v=4",
                name: "EasyFirebaseSwift",
                description: "An Easy Firebase (Auth / Firestore) Library written in Swift.",
                isPrivate: false,
                createDate: "2021/1/1",
                url: "https://github.com/fummicc1/EasyFirebaseSwift",
                languages: [.init(name: "Swift", color: "F05138")],
                mostUsedLangauge: .init(name: "Swift", color: "F05138")
            )
        )
        .previewLayout(.sizeThatFits)
        
    }
}
