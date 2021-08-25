//
//  RepositoryListViewModelTests.swift
//  GitHubClientTests
//
//  Created by Fumiya Tanaka on 2021/08/22.
//

import XCTest
@testable import GitHubClient

class RepositoryListViewModelTests: XCTestCase {

    var target: RepositoryListViewModel!
    var useCase: RepositoryUseCaseMock!
    
    override func setUpWithError() throws {
        useCase = RepositoryUseCaseMock()
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
        target.query = "fummicc1"
        
        useCase.registerExpected(.init(action: RepositoryUseCaseMock.Function.Action.searchWithQuery(query: "fummicc1")))
        useCase.set(keyPath: \.searchWithQuery, value: .success(repositoryList))
        
        // Execute
        target.fetch()
        
        // Validate
        useCase.validate()
        let (exp, _) = target.$repositories.validate(
            timeout: 2, equals: [viewDataList])
        wait(for: [exp], timeout: 2)
    }
}
