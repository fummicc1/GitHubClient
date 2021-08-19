//
//  ProfileUseCase.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol ProfileUseCaseProtocol: AnyObject {
    func getMe()
    func get(with id: GitHubUserLoginID)
}
