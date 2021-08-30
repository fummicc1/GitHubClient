//
//  GitHubOAuthUseCaseMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/30.
//

import Foundation
@testable import GitHubClient

class GitHubOAuthIUseCaseMock: Mock, MockOutput, GitHubOAuthIUseCaseProtocol {
    
    var dto: DTO = .init()
    
    func checkHasAccessToken() -> AnyPublisher<Bool, Error> {
        
    }
    
    func findAccessToken() -> AnyPublisher<String?, Error> {
        
    }
    
    func onReceiveAccessToken() -> AnyPublisher<String, Error> {
        
    }
    
    func updateCode(_ code: String) -> AnyPublisher<Void, Error> {
        
    }
}

extension GitHubOAuthIUseCaseMock {
    
    // Input
    struct Function: MockFunction {
        var numberOfCall: Int = 0
        var action: Action
        
        enum Action: Hashable {
            case checkHasAccessToken
            case findAccessToken
            case onReceiveAccessToken
            case updateCode
        }
    }
    
    // Output
    struct DTO {
        let checkHasAccessToken: Result<Bool, Error> = .failure(MockError.notConfigured)
        
    }
}
