//
//  ProfileInteractorTests.swift
//  Tests iOS
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import XCTest
import Combine
@testable import GitHubClient

class ProfileInteractorTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GetMe() throws {
        let requestable = MyProfileRequestableMock()
        let interactor = ProfileInteractor(profileClient: requestable)
        XCTAssertFalse(requestable.isCalledFetch)
        XCTAssertEqual(requestable.numberOfCall, 0)
        
        let expectation = expectation(description: "Get me")
        
        interactor.execute()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    XCTAssertTrue(requestable.isCalledFetch)
                    XCTAssertEqual(requestable.numberOfCall, 1)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
