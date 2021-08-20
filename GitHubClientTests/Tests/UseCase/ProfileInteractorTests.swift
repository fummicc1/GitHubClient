//
//  ProfileInteractorTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import XCTest
@testable import GitHubClient

class ProfileInteractorTests: XCTestCase {
    
    var target: ProfileInteractor!
    var output: ProfileUseCaseOutputMock!
    var gateway: ProfileGatewayMock!

    override func setUpWithError() throws {
        gateway = ProfileGatewayMock()
        output = ProfileUseCaseOutputMock()
        target = ProfileInteractor(userGateway: gateway, output: output)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getMe() throws {
        
        // Configure
        let meStub = MeEntity.stub()
        
        gateway.registerExpected(.init(action: .fetchMe))
        output.registerExpected(.init(action: .didFindMe(meStub)))
        
        gateway.fetchMeResponse = .success(meStub)
        
        // Execute
        target.getMe()
                
        // Validate
        gateway.validate(file: #file, line: #line)
        output.validate(file: #file, line: #line)
    }
    
    func test_get() throws {
        // Configure
        let userStub = GitHubUser.stub()
        
        gateway.registerExpected(.init(action: .fetchWithID(userStub.login)))
        output.registerExpected(.init(action: .didFindUser(userStub)))
        
        gateway.fetchWithIDResponse = .success(userStub)
        
        // Execute
        target.get(with: userStub.login)
        
        // Validate
        gateway.validate(file: #file, line: #line)
        output.validate(file: #file, line: #line)        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
