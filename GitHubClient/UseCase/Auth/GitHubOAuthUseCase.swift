//
//  GitHubOAuthUseCase.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Combine

protocol GitHubOAuthIUseCaseProtocol {
    func onAccessToken() -> AnyPublisher<String, Error>
    func getAccessToken() -> AnyPublisher<String?, Error>
    func checkHasAccessToken() -> AnyPublisher<Bool, Error>
    
    func updateCode(_ code: String) -> AnyPublisher<Void, Error>
}
