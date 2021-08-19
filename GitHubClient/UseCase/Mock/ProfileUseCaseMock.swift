//
//  ProfileUseCaseMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation

class ProfileInteractorMock: ProfileUseCaseProtocol {
    
    enum Error: Swift.Error {
        case noUserFound
    }
    
    private var output: ProfileUseCaseOutput!
    
    func inject(
        output: ProfileUseCaseOutput?
    ) {
        self.output = output
    }
    
    func getMe() {
        let stub = MeEntity.stub()
        output.didFindMe(stub)
    }
    
    func get(with id: GitHubUserLoginID) {
        let stub = GitHubUser.stub()
        if stub.login == id {
            output.didFindUser(stub)
        } else {
            output.didOccureError(Error.noUserFound)
        }
    }
    
    
}
