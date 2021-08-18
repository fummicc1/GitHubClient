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
            repository: GitHubRepositoryViewData.stub()
        )
    }
}
