//
//  ProfileInteractorTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/20.
//

import XCTest
import Combine
@testable import GitHubClient

class ProfileInteractorTests: XCTestCase {
    
    var target: ProfileInteractor!
    var repoGateway: RepositoryGatewayProtocolMock!
    var profileGateway: UserGatewayProtocolMock!

    override func setUpWithError() throws {
        profileGateway = UserGatewayProtocolMock()
        repoGateway = RepositoryGatewayProtocolMock()
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
        
        profileGateway.fetchMeFollowerCountFolloweeCountReturnValue = Just(meStub).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        // Execute
        let result = target.getMe()
        
        // Validate
        let (expectation, _) = result.validate(equals: [meStub])
        
        XCTAssertTrue(profileGateway.fetchMeFollowerCountFolloweeCountCalled)
        XCTAssertEqual(profileGateway.fetchMeFollowerCountFolloweeCountReceivedArguments?.followeeCount, ProfileInteractor.defaultFetchCount)
        XCTAssertEqual(profileGateway.fetchMeFollowerCountFolloweeCountReceivedArguments?.followerCount, ProfileInteractor.defaultFetchCount)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_getMyRepoList_canSuccess() throws {
        
        // Configure
        let me = MeEntity.stub()
        let myRepoList = GitHubRepositoryList.stub()
        
        profileGateway.fetchMeFollowerCountFolloweeCountReturnValue = Just(me).setFailureType(to: Error.self).eraseToAnyPublisher()
        repoGateway.searchRepoListOfReturnValue = Just(myRepoList).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        // Execute
        let result = target.getMyRepoList()
        
        // Validate
        let (exp, _) = result.validate(equals: [myRepoList]) // ここでSinkしているので検証処理の最初に実行する必要がある
        
        XCTAssertEqual(profileGateway.fetchMeFollowerCountFolloweeCountReceivedArguments?.followeeCount, ProfileInteractor.defaultFetchCount)
        XCTAssertEqual(profileGateway.fetchMeFollowerCountFolloweeCountReceivedArguments?.followerCount, ProfileInteractor.defaultFetchCount)
        XCTAssertEqual(repoGateway.searchRepoListOfReceivedId, me.login)
        
        wait(for: [exp], timeout: 2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
