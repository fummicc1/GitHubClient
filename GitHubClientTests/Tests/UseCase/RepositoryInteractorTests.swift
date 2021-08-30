//
//  RepositoryInteractorTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import XCTest
import Combine
@testable import GitHubClient

class RepositoryInteractorTests: XCTestCase {
    
    var target: RepositoryInteractor!
    var gateway: RepositoryGatewayProtocolMock!
    
    override func setUpWithError() throws {
        gateway = RepositoryGatewayProtocolMock()
        target = RepositoryInteractor(repositoryGateway: gateway)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_searchWithQuery_canSuccess() {
        
        let repoList = GitHubRepositoryList.stub()
        
        let query = repoList.repositories.first!.name
        
        let count = 10
        
        gateway.searchWithCountReturnValue = Just(repoList).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let result = target.search(with: query, count: count)
                
        XCTAssertTrue(gateway.searchWithCountCalled)
        XCTAssertEqual(gateway.searchWithCountReceivedArguments?.query, query)
        XCTAssertEqual(gateway.searchWithCountReceivedArguments?.count, count)
        
        let (exp, _) = result.validate(timeout: 2, equals: [repoList])
        wait(for: [exp], timeout: 2)
    }
    
    func test_searchSpecificRepo_canSuccess() {
        // Config
        let repo = GitHubRepository.stub()
        
        let owner = GitHubUserLoginID(id: "fummicc1")
        
        let repoName = "fummicc1"
        
        gateway.searchOfRepoNameReturnValue = Just(repo).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        // Execute
        let result = target.search(of: owner, repoName: repoName)
                  
        // Validate
        XCTAssertTrue(gateway.searchOfRepoNameCalled)
        XCTAssertEqual(gateway.searchOfRepoNameReceivedArguments?.owner, owner)
        XCTAssertEqual(gateway.searchOfRepoNameReceivedArguments?.repoName, repoName)
        
        let (exp, _) = result.validate(equals: [repo])
        wait(for: [exp], timeout: 2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
