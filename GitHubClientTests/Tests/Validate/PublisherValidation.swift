//
//  PublisherValidation.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/22.
//

import Foundation
import Combine
import XCTest

extension Publisher where Self.Output: Equatable {
    
    typealias CompletionResult = (expectation: XCTestExpectation,
                                   cancellable: AnyCancellable)
    
    func validate(
        timeout: TimeInterval,
        file: StaticString = #file,
        line: UInt = #line,
        equals: [Self.Output]
    ) -> CompletionResult {
        let expectation = XCTestExpectation(description: "Publisher: \(String(describing: self))")
        var mutableEquals = equals
        let cancellable = sink { completion in
        } receiveValue: { output in
            if let value = mutableEquals.first {
                XCTAssertEqual(value, output)
                mutableEquals.removeFirst()
                if mutableEquals.isEmpty {
                    expectation.fulfill()
                }
            }
        }
        return (expectation, cancellable)
    }
}

