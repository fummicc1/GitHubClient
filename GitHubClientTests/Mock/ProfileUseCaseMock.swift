//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
@testable import GitHubClient

class ProfileInteractorMock: Mock, ProfileUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case getMe
            case get
        }
    }
    
    func getMe() {
        let function = Function(action: .getMe)
        register(function)
    }
    
    func get(with id: GitHubUserLoginID) {
        let function = Function(action: .get)
        register(function)
    }
    
}
