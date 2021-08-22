//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
@testable import GitHubClient

class ProfileUseCaseMock: Mock, MockOutput, ProfileUseCaseProtocol {
    
    var expected: [Function] = []
    var actual: [Function] = []
    
    var output: ProfileUseCaseOutput!
    
    var dto: DTO = .init()
    
    func inject(output: ProfileUseCaseOutput) {
        self.output = output
    }
    
    func getMe() {
        let function = Function(action: .getMe)
        registerActual(function)
        
        let response = dto.me
        switch response {
        case .success(let me):
            output.didFind(me: me)
        case .failure(let error):
            output.didOccureError(error)
        }
    }
    
    func getMyRepoList() {
        registerActual(.init(action: .getMyRepoList))
        
        let response = dto.myRepoList
        switch response {
        case .success(let list):
            output.didFind(repoList: list)
        case .failure(let error):
            output.didOccureError(error)
        }
    }
}

extension ProfileUseCaseMock {
    struct DTO {
        var me:Result<MeEntity, Error> = .failure(MockError.notConfigured)
        var myRepoList: Result<GitHubRepositoryList, Error> = .failure(MockError.notConfigured)
    }
    
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Equatable {
            case getMe
            case getMyRepoList
        }
    }
}
