//
//  AppViewModelTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/30.
//

import XCTest
@testable import GitHubClient

class AppViewModelTests: XCTestCase {
    
    var target: AppViewModel!
    var authUseCase: GitHubOAuthIUseCaseProtocolMock!
    var profileUseCase: ProfileUseCaseProtocolMock!

    override func setUpWithError() throws {
        authUseCase = GitHubOAuthIUseCaseProtocolMock()
        target = AppViewModel(profileUseCase: profileUseCase, authUseCase: authUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
