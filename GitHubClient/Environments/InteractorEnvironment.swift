//
//  InteractorEnvironment.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/15.
//

import Foundation
import SwiftUI

struct ProfileUseCaseKey: EnvironmentKey {
    static var defaultValue: ProfileUseCaseProtocol {
        ProfileInteractor()
    }
}

struct RepositoryUseCaseKey: EnvironmentKey {
    static var defaultValue: RepositoryUseCaseProtocol {
        RepositoryUseCase()
    }
}

extension EnvironmentValues {
    var profileUseCase: ProfileUseCaseProtocol {
        get {
            self[ProfileUseCaseKey.self]
        }
        set {
            self[ProfileUseCaseKey.self] = newValue
        }
    }
    
    var repositoryUseCase: RepositoryUseCaseProtocol {
        get {
            self[RepositoryUseCaseKey.self]
        }
        set {
            self[RepositoryUseCaseKey.self] = newValue
        }
    }
}
