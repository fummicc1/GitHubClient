//
//  SearchRepositoryClientTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/07/28.
//

import XCTest
import Combine
@testable import GitHubClient

class SearchRepositoryClientTests: XCTestCase {

    var client: SearchRepositoryApiClient = SearchRepositoryApiClient(
        apollo: APIClient.gitHubClient
    )
    
    var cancellable: Set<AnyCancellable> = Set()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FetchSearchRepository() {
        let expectation = expectation(description: "Search fummicc1 Repo")
        
        let query = SearchRepositoryQuery(query: "fummicc1", count: 1)
        
        client.fetch(query: query)
            .sink(receiveCompletion: { result in
                
                switch result {
                case .finished:
                    break
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    
                }
                
            }) { repositories in
                
                let count = repositories.count
                
                XCTAssertNotNil(repositories.first)
                XCTAssertEqual(count, 1)
                
                let owner = repositories.first!.owner.login
                
                XCTAssert(owner.contains("fummicc1"))
                
                expectation.fulfill()
                
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
