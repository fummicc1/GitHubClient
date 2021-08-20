//
//  Mock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import XCTest
@testable import GitHubClient

protocol Mock: AnyObject {
    associatedtype Function: MockFunction
    var expected: [Function] { get set }
    var actual: [Function] { get set }
    
    func register(_ function: Function)
    func validate(file: StaticString, line: UInt)
}

protocol MockFunction: Equatable {
    var action: Action { get }
    var numberOfCall: Int { get set }
    
    associatedtype Action: Equatable
}

extension Mock {
    func register(_ function: Function) {
        var f = function
        if var old = actual.first(where: { $0.action == function.action }) {
            old.numberOfCall += 1
            f = old
        }
        actual.append(f)
    }
    
    func validate(file: StaticString, line: UInt) {
        if actual == expected {
            return
        }
        let expMessage = expected.map({ function in
            String(describing: function)
        })
        let actualMessage = actual.map({ function in
            String(describing: function)
        })
        XCTFail("fail to validate.\n Excpeted: \(expMessage)\n Actual: \(actualMessage)", file: file, line: line)
    }
}

// MARK: Default Initializer
extension Mock {
    init(
        expected: [Function]
    ) {
        self.expected = expected
        self.actual = []
    }
}
