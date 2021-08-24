//
//  RepositoryInteractorTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/21.
//

import XCTest
@testable import GitHubClient

class RepositoryInteractorTests: XCTestCase {
    
    var target: RepositoryInteractor!
    var gateway: RepositoryGatewayMock!
    
    override func setUpWithError() throws {
        gateway = RepositoryGatewayMock()
        target = RepositoryInteractor(repositoryGateway: gateway)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_searchWithQuery_canSuccess() {
        
        let repoList = GitHubRepositoryList.stub()
        
        let query = repoList.repositories.first!.name
        
        let count = 10
        
        gateway.registerExpected(
            .init(action: .searchWithQuery(query: query, count: count))
        )
        gateway.set(keyPath: \.searchWithQuery, value: .success(repoList))
        
        let result = target.search(with: query, count: count)
                
        gateway.validate()
        
        let (exp, _) = result.validate(timeout: 2, equals: [repoList])
        wait(for: [exp], timeout: 2)
    }
    
    func test_searchSpecificRepo_canSuccess() {
        // Config
        let repo = GitHubRepository.stub()
        
        let owner = GitHubUserLoginID(id: "fummicc1")
        
        let repoName = "fummicc1"
        
        gateway.registerExpected(
            .init(action: .searchSpecificRepository(owner: owner, repoName: repoName))
        )
        
        gateway.set(keyPath: \.searchSpecific, value: .success(repo))
        
        // Execute
        let result = target.search(of: owner, repoName: repoName)
                  
        // Validate
        gateway.validate()
        
        let (exp, _) = result.validate(timeout: 2, equals: [repo])
        wait(for: [exp], timeout: 2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
