//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
@testable import GitHubClient

class ProfileUseCaseMock: Mock, ProfileUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case getMe
            case getMyRepoList
        }
    }
    
    func getMe() {
        let function = Function(action: .getMe)
        registerActual(function)
    }
    
    func getMyRepoList() {
        registerActual(.init(action: .getMyRepoList))
    }
}
