//
//  MyProfileRequestableMock.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine
@testable import GitHubClient

class MyProfileRequestableMock: MyProfileRequestable {
    
    var isCalledFetch: Bool = false
    var numberOfCall: Int = 0
    
    func fetch(query: MyProfileQuery) -> AnyPublisher<MyProfileQuery.Data.Viewer, Error> {
        isCalledFetch = true
        numberOfCall += 1
        
        let data: MyProfileQuery.Data.Viewer = MyProfileQuery.Data.Viewer(
            login: "fummicc1",
            avatarUrl: "https://avatars.githubusercontent.com/u/44002126?v=4",
            followers: MyProfileQuery.Data.Viewer.Follower(
                totalCount: 1,
                nodes: [
                    MyProfileQuery.Data.Viewer.Follower.Node(
                        avatarUrl: "https://avatars.githubusercontent.com/u/44002126?v=4",
                        login: "fummicc1"
                    )
                ]
            ),
            following: MyProfileQuery.Data.Viewer.Following(totalCount: 0, nodes: [])
        )
        
        return Just(data).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
