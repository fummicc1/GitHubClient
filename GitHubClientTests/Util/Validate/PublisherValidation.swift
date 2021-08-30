//
//  PublisherValidation.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/22.
//

import Foundation
import Combine
import XCTest

typealias CompletionResult = (expectation: XCTestExpectation,
                               cancellable: AnyCancellable)

extension Publisher where Self.Output: Equatable {
    
    func validate(        
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

extension Publisher {
    func validateNotNil<T>(
        type: T.Type,
        streamCount: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> CompletionResult where Self.Output == Optional<T> {
        var leftCount: Int = streamCount
        let expectation = XCTestExpectation(description: "Publisher: \(String(describing: self))")
        let cancellable = sink { _ in
        } receiveValue: { output in
            XCTAssertNotNil(output)
            leftCount -= 1
            if leftCount == 0 {
                expectation.fulfill()
            }
        }
        return (expectation, cancellable)
    }
    
    func validateCount(
        streamCount: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> CompletionResult {
        var leftCount: Int = streamCount
        let expectation = XCTestExpectation(description: "Publisher: \(String(describing: self))")
        let cancellable = sink { _ in
        } receiveValue: { _ in            
            leftCount -= 1
            if leftCount == 0 {
                expectation.fulfill()
            }
        }
        return (expectation, cancellable)
    }
}
