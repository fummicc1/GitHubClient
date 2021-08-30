//
//  ProfileViewModelTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/24.
//

import XCTest
import Combine
@testable import GitHubClient

class ProfileViewModelTests: XCTestCase {

    var target: MyProfileViewModel!
    var useCase: ProfileUseCaseProtocolMock!
    
    override func setUpWithError() throws {
        useCase = ProfileUseCaseProtocolMock()
        target = MyProfileViewModel(useCase: useCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_findMyRepoList_canSuccess() throws {
        
        // Config
        let viewData = [GitHubRepositoryViewData.stub()]
        let data = GitHubRepositoryList.stub()
        
        useCase.getMyRepoListReturnValue = Just(data).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        // Execute
        target.findMyRepoList()
        
        // Validate
        
        XCTAssertEqual(useCase.getMyRepoListCallsCount, 1)
        
        let result = target.$myRepoList
        let (exp, _) = result.validate(timeout: 2, equals: [viewData])
        
        wait(for: [exp], timeout: 2)
    }
    
    func test_findMe_canSuccess() throws {
        let viewData = MeViewData.stub()
        let data = MeEntity.stub()
        
        useCase.getMeReturnValue = Just(data).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        // Execute
        target.findMe()
        
        // Validate
        
        XCTAssertEqual(useCase.getMeCallsCount, 1)
        
        let me = target.$me
        let (exp, _) = me.validateNotNil(
            type: MeViewData.self,
            streamCount: 1
        )
        let (exp2, _) = me.compactMap({ $0 })
            .validate(timeout: 2, equals: [viewData])
        wait(for: [exp, exp2], timeout: 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
