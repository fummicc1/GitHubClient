//
//  APIRequestables.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/15.
//

import Foundation
import Apollo
import SwiftUI

struct GitHubClientKey: EnvironmentKey {
    static var defaultValue: ApolloClient {
        APIClient.gitHubClient
    }
}

struct ProfileAPIClientKey: EnvironmentKey {
    static var defaultValue: ProfileApiClient {
        ProfileApiClient(apollo: GitHubClientKey.defaultValue)
    }
}

struct MyProfileAPIClientKey: EnvironmentKey {
    static var defaultValue: MyProfileApiClient {
        MyProfileApiClient(apollo: GitHubClientKey.defaultValue)
    }
}

struct SpecificRepositoryAPIClientKey: EnvironmentKey {
    static var defaultValue: SpecificRepositoryApiClient {
        SpecificRepositoryApiClient(apollo: GitHubClientKey.defaultValue)
    }
}

struct SearchRepositoryAPIClientKey: EnvironmentKey {
    static var defaultValue: SearchRepositoryApiClient {
        SearchRepositoryApiClient(apollo: GitHubClientKey.defaultValue)
    }
}

// MARK: Values
extension EnvironmentValues {
    
    
    // MARK: Repository
    var searchRepositoryAPIClient: SearchRepositoryApiClient {
        get {
            self[SearchRepositoryAPIClientKey.self]
        }
        set {
            self[SearchRepositoryAPIClientKey.self] = newValue
        }
    }
    
    var specificRepositoryAPIClient: SpecificRepositoryApiClient {
        get {
            self[SpecificRepositoryAPIClientKey.self]
        }
        set {
            self[SpecificRepositoryAPIClientKey.self] = newValue
        }
    }
    
    
    // MARK: Profile
    var myProfileAPIClient: MyProfileApiClient {
        get {
            self[MyProfileAPIClientKey.self]
        }
        set {
            self[MyProfileAPIClientKey.self] = newValue
        }
    }
   
    var profileAPIClient: ProfileApiClient {
        get {
            self[ProfileAPIClientKey.self]
        }
        set {
            self[ProfileAPIClientKey.self] = newValue
        }
    }
    
    // MARK: ApolloClient
    var apolloClient: ApolloClient {
        get {
            self[GitHubClientKey.self]
        }
        set {
            self[GitHubClientKey.self] = newValue
        }
    }
}
