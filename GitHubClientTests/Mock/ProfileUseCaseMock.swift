//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
@testable import GitHubClient

class ProfileInteractorMock: Mock, ProfileUseCaseProtocol {
    
    var expected: [Functions] = []
    var actual: [Functions] = []
    
    enum Functions: Equatable {
        case getMe
        case get
    }
    
    typealias Function = Functions
    
    
    func getMe() {
        register(.getMe)
    }
    
    func get(with id: GitHubUserLoginID) {
        register(.get)
    }
    
}
