//
//  DataStore.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/26.
//

import Foundation
import Combine
import KeychainAccess

protocol DataStoreProtocol {
    func observe(key: String) -> AnyPublisher<String, Error>
    func get(key: String) throws -> String?
    func save(_ value: String, key: String) throws
}

class DataStore {
    
    private let keychain: Keychain
    private var subjects: [String: PassthroughSubject<String, Error>] = [:]
    
    init(keychain: Keychain = Keychain(service: "dev.fummicc1.github-client")) {
        self.keychain = keychain
    }
}

extension DataStore: DataStoreProtocol {
    
    func observe(key: String) -> AnyPublisher<String, Error> {
        if let subject = subjects[key] {
            return subject.eraseToAnyPublisher()
        } else {
            let subject = PassthroughSubject<String, Error>()
            subjects[key] = subject
            return subject.eraseToAnyPublisher()
        }
    }
    
    func get(key: String) throws -> String? {
        try keychain.get(key)
    }
    
    func save(_ value: String, key: String) throws {
         try keychain.set(value, key: key)
        
        if let subject = subjects[key] {
            subject.send(value)
        }
    }
}
