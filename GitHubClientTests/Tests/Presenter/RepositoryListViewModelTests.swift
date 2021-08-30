//
//  RepositoryListViewModelTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/22.
//

import XCTest
import Combine
@testable import GitHubClient

class RepositoryListViewModelTests: XCTestCase {

    var target: RepositoryListViewModel!
    var useCase: RepositoryUseCaseProtocolMock!
    
    override func setUpWithError() throws {
        useCase = RepositoryUseCaseProtocolMock()
        target = RepositoryListViewModel(useCase: useCase)
    }

    override func tearDownWithError() throws {
    }

    func test_fetch_canSucceed() throws {
        
        // Config
        
        let repo = GitHubRepository.stub()
        let repositoryList = GitHubRepositoryList(repositories: [repo])
        
        // FIXME: Support Localized String
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .none
        dateformatter.locale = Locale.current
        
        let viewData = GitHubRepositoryViewData(
            id: repo.id.id,
            userName: repo.owner.loginID,
            avatarURL: repo.owner.avatarUrl,
            name: repo.name,
            description: repo.description,
            isPrivate: repo.isPrivate,
            createDate: dateformatter.string(from: repo.createdAt), // TODO: Test for other locales
            url: repo.url,
            languages: [.stub()],
            mostUsedLangauge: .stub()
        )
        let viewDataList = [viewData]
        
        let query = "fummicc1"
        let count = 10
        
        target.query = query
        
        useCase.searchWithCountReturnValue = Just(repositoryList).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        // Execute
        target.fetch(count: count)
        
        // Validate
        XCTAssertTrue(useCase.searchWithCountCalled)
        XCTAssertEqual(useCase.searchWithCountReceivedArguments?.query, query)
        XCTAssertEqual(useCase.searchWithCountReceivedArguments?.count, count)
        
        let (exp, _) = target.$repositories.validate(
            timeout: 2, equals: [viewDataList])
        wait(for: [exp], timeout: 2)
    }
}
