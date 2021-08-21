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
    var repoGateway: RepositoryGatewayMock!
    var profileGateway: ProfileGatewayMock!

    override func setUpWithError() throws {
        profileGateway = ProfileGatewayMock()
        repoGateway = RepositoryGatewayMock()
        output = ProfileUseCaseOutputMock()
        target = ProfileInteractor(
            userGateway: profileGateway,
            repoGateway: repoGateway,
            output: output
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getMe_canSucceed() throws {
        
        // Configure
        let meStub = MeEntity.stub()
        
        profileGateway.registerExpected(.init(action: .fetchMe))
        output.registerExpected(.init(action: .didFindMe(meStub)))
        
        profileGateway.fetchMeResponse = .success(meStub)
        
        // Execute
        target.getMe()
        
        // Validate
        profileGateway.validate()
        output.validate()
    }
    
    func test_getMyRepoList_canFail() throws {
        
        // Configure
        let me = MeEntity.stub()
        let myRepoList = GitHubRepositoryList.stub()
        
        let outputError = ProfileInteractor.Error.didNotFoundMe
        
        repoGateway.registerExpected(.init(action: .searchRepoListOfUser(userID: me.login)))
        output.registerExpected(
            .init(
                action: .didOccureError(
                    message: outputError.localizedDescription
                )
            )
        )
        
        repoGateway.searchRepoListResponse = .success(myRepoList)
        
        // Execute
        target.getMyRepoList()
        
        // Validate
        profileGateway.validate()
        output.validate()
        
    }
    
    func test_getMyRepoList_canSuccess() throws {
        
        // Configure
        let me = MeEntity.stub()
        let myRepoList = GitHubRepositoryList.stub()
        
        let getMeExpectation = XCTestExpectation(description: "Wait for getMe()")
        
        profileGateway.registerExpected(
            .init(
                action: .fetchMe
            )
        )
        
        repoGateway.registerExpected(
            .init(
                action: .searchRepoListOfUser(userID: me.login)
            )
        )
        
        output.registerExpected(
            .init(
                action: .didFindMe(me)
            )
        )
        output.registerExpected(
            .init(
                action: .didFindRepoList(repoList: myRepoList)
            )
        )
        
        output.relate(exp: getMeExpectation, to: .didFindMe(me))
        
        repoGateway.searchRepoListResponse = .success(myRepoList)
        profileGateway.fetchMeResponse = .success(me)
        
        // Execute
        target.getMe()
        
        wait(for: [getMeExpectation], timeout: 2)
        
        target.getMyRepoList()
        
        // Validate
        profileGateway.validate()
        output.validate()
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
