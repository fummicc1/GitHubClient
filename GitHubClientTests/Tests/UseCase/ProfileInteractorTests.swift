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
    var repoGateway: RepositoryGatewayMock!
    var profileGateway: ProfileGatewayMock!

    override func setUpWithError() throws {
        profileGateway = ProfileGatewayMock()
        repoGateway = RepositoryGatewayMock()
        target = ProfileInteractor(
            userGateway: profileGateway,
            repoGateway: repoGateway
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getMe_canSucceed() throws {
        
        // Configure
        let meStub = MeEntity.stub()
        
        profileGateway.registerExpected(
            .init(
                action: .fetchMe(
                    followerCount: ProfileInteractor.defaultFetchCount,
                    followeeCount: ProfileInteractor.defaultFetchCount
                )
            )
        )
        
        profileGateway.set(keyPath: \.me, value: .success(meStub))
        
        // Execute
        let result = target.getMe()
        
        // Validate
        profileGateway.validate()
        
        let (expectation, _) = result.validate(timeout: 2, equals: [meStub])
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_getMyRepoList_canSuccess() throws {
        
        // Configure
        let me = MeEntity.stub()
        let myRepoList = GitHubRepositoryList.stub()
        
        repoGateway.registerExpected(.init(action: .searchRepoListOfUser(userID: me.login)))        
        repoGateway.set(keyPath: \.searchRepoList, value: .success(myRepoList))
        profileGateway.registerExpected(
            .init(
                action: .fetchMe(
                    followerCount: ProfileInteractor.defaultFetchCount,
                    followeeCount: ProfileInteractor.defaultFetchCount
                )
            )
        )
        profileGateway.set(keyPath: \.me, value: .success(me))
        
        // Execute
        let result = target.getMyRepoList()
        
        // Validate
        profileGateway.validate()
        
        let (exp, _) = result.validate(timeout: 2, equals: [myRepoList])
        wait(for: [exp], timeout: 2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
