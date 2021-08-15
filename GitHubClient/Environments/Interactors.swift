//
//  Interactors.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/15.
//

import Foundation
import SwiftUI

struct ProfileUseCaseKey: EnvironmentKey {
    static var defaultValue: GetMyProfileUseCase & GetOtherProfileUseCase {
        ProfileInteractor(
            profileClient: ProfileAPIClientKey.defaultValue,
            myProfileClient: MyProfileAPIClientKey.defaultValue
        )
    }
}

struct RepositoryUseCaseKey: EnvironmentKey {
    static var defaultValue: GetRepositoryUseCase {
        
        let search = SearchRepositoryAPIClientKey.defaultValue
        let specific = SpecificRepositoryAPIClientKey.defaultValue
        
        return RepositoryInteractor(searchClient: search, specificClient: specific)
    }
}

extension EnvironmentValues {
    var profileUseCase: GetMyProfileUseCase & GetOtherProfileUseCase {
        get {
            self[ProfileUseCaseKey.self]
        }
        set {
            self[ProfileUseCaseKey.self] = newValue
        }
    }
    
    var repositoryUseCase: GetRepositoryUseCase {
        get {
            self[RepositoryUseCaseKey.self]
        }
        set {
            self[RepositoryUseCaseKey.self] = newValue
        }
    }
}
