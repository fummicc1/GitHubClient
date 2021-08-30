//
//  AuthInteractorTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/30.
//

import XCTest
import Combine
@testable import GitHubClient

class AuthInteractorTests: XCTestCase {

    var target: GitHubOAuthInteractor!
    var authGateway: AuthGatewayProtocolMock!
    
    override func setUpWithError() throws {
        authGateway = AuthGatewayProtocolMock()
        target = GitHubOAuthInteractor(authGateway: authGateway)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_onReceiveAccessToken_canSuccess() throws {
        
        authGateway.onAccessTokenChangedReturnValue = Publishers.Merge(
            Just("test"),
            Just("test_next")
        ).setFailureType(to: Error.self).eraseToAnyPublisher()
        authGateway.registerAccessTokenReturnValue = Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let receivedTokenPublisher = target.onReceiveAccessToken()
        
        let (exp, _) = receivedTokenPublisher.validate(equals: ["test"])
        
        wait(for: [exp], timeout: 2)
    }
    
    func test() throws {
        let accessToken = "test"
        let code = "code"
        authGateway.requestAccessTokenWithReturnValue = Just(accessToken).setFailureType(to: Error.self).eraseToAnyPublisher()
        authGateway.persistAccessTokenReturnValue = Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let updateCodePublisher = target.updateCode(code)
        let (exp, _) = updateCodePublisher.validateCount(streamCount: 1)
        wait(for: [exp], timeout: 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
