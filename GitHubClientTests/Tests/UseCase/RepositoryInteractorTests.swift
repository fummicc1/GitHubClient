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
    var output: RepositoryUseCaseOutputMock!
    
    override func setUpWithError() throws {
        gateway = RepositoryGatewayMock()
        output = RepositoryUseCaseOutputMock()
        target = RepositoryInteractor(repositoryGateway: gateway)
        target.inject(output: output)
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
        output.registerExpected(
            .init(action: .didCompleteSearch(repoList))
        )
        gateway.set(keyPath: \.searchWithQuery, value: .success(repoList))
        
        target.search(with: query, count: count)
        
        output.validate()
        gateway.validate()
    }
    
    func test_searchSpecificRepo_canSuccess() {
        let repo = GitHubRepository.stub()
        let repoList = GitHubRepositoryList(repositories: [repo])
        
        let owner = GitHubUserLoginID(id: "fummicc1")
        
        let repoName = "fummicc1"
        
        gateway.registerExpected(
            .init(action: .searchSpecificRepository(owner: owner, repoName: repoName))
        )
        output.registerExpected(
            .init(action: .didCompleteSearch(repoList))
        )
        
        gateway.set(keyPath: \.searchSpecific, value: .success(repo))
        
        target.search(of: owner, repoName: repoName)
        
        output.validate()
        gateway.validate()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
