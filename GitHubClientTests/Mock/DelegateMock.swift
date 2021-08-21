//
//  DelegateMock.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import XCTest

protocol DelegateMock: Mock {
    var expectations: [Function.Action: XCTestExpectation] { get }
    func relate(exp: XCTestExpectation, to action: Function.Action)
}

extension DelegateMock {
    func registerActual(_ function: Function) {
        var f = function
        if var old = actual.first(where: { $0.action == function.action }) {
            old.numberOfCall += 1
            f = old
        }
        actual.append(f)
        
        if let exp = expectations[function.action] {
            exp.fulfill()
        }
    }
}
