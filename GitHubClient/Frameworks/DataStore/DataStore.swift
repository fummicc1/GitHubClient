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
    
    enum CachedPath {
        case repositories
        case users
        case profile
        
        var appendingPath: String {
            switch self {
            case .repositories:
                return "/repositories"
                
            case .profile:
                return "/profile"
                
            case .users:
                return "/users"
            }
        }
    }
    
    private let baseFileURL: URL
    private let fileManager: FileManager
    private let keychain: Keychain
    private var subjects: [String: PassthroughSubject<String, Error>] = [:]
    
    init(keychain: Keychain = Keychain(service: "dev.fummicc1.github-client"), fileManager: FileManager = FileManager.default) {
        self.keychain = keychain
        self.fileManager = fileManager
        
        let bundleID = Bundle.main.bundleIdentifier!
        
        baseFileURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(bundleID)
    }
}

extension DataStore: DataStoreProtocol {
    
    func createCache<Value: Encodable>(
        to path: CachedPath,
        value: Value,
        encoder: JSONEncoder = JSONEncoder()
    ) throws {
        let data = try encoder.encode(value)
        let url = baseFileURL.appendingPathComponent(path.appendingPath)
        if !fileManager.fileExists(atPath: url.absoluteString) {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        try data.write(to: url)
    }
    
    func fetchCache<Value: Decodable>(
        from path: CachedPath,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> Value {
        let url = baseFileURL.appendingPathComponent(path.appendingPath)
        let data = try Data(contentsOf: url)
        let decoded = try decoder.decode(Value.self, from: data)
        return decoded
    }
    
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
