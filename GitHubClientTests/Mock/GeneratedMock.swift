// Generated using Sourcery 1.5.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Combine

@testable import GitHubClient














class AuthGatewayProtocolMock: AuthGatewayProtocol {

    //MARK: - persistAccessToken

    var persistAccessTokenCallsCount = 0
    var persistAccessTokenCalled: Bool {
        return persistAccessTokenCallsCount > 0
    }
    var persistAccessTokenReceivedAccessToken: String?
    var persistAccessTokenReceivedInvocations: [String] = []
    var persistAccessTokenReturnValue: AnyPublisher<Void, Error>!
    var persistAccessTokenClosure: ((String) -> AnyPublisher<Void, Error>)?

    func persistAccessToken(_ accessToken: String) -> AnyPublisher<Void, Error> {
        persistAccessTokenCallsCount += 1
        persistAccessTokenReceivedAccessToken = accessToken
        persistAccessTokenReceivedInvocations.append(accessToken)
        return persistAccessTokenClosure.map({ $0(accessToken) }) ?? persistAccessTokenReturnValue
    }

    //MARK: - registerAccessToken

    var registerAccessTokenCallsCount = 0
    var registerAccessTokenCalled: Bool {
        return registerAccessTokenCallsCount > 0
    }
    var registerAccessTokenReceivedAccessToken: String?
    var registerAccessTokenReceivedInvocations: [String] = []
    var registerAccessTokenReturnValue: AnyPublisher<Void, Error>!
    var registerAccessTokenClosure: ((String) -> AnyPublisher<Void, Error>)?

    func registerAccessToken(_ accessToken: String) -> AnyPublisher<Void, Error> {
        registerAccessTokenCallsCount += 1
        registerAccessTokenReceivedAccessToken = accessToken
        registerAccessTokenReceivedInvocations.append(accessToken)
        return registerAccessTokenClosure.map({ $0(accessToken) }) ?? registerAccessTokenReturnValue
    }

    //MARK: - onAccessTokenChanged

    var onAccessTokenChangedCallsCount = 0
    var onAccessTokenChangedCalled: Bool {
        return onAccessTokenChangedCallsCount > 0
    }
    var onAccessTokenChangedReturnValue: AnyPublisher<String, Error>!
    var onAccessTokenChangedClosure: (() -> AnyPublisher<String, Error>)?

    func onAccessTokenChanged() -> AnyPublisher<String, Error> {
        onAccessTokenChangedCallsCount += 1
        return onAccessTokenChangedClosure.map({ $0() }) ?? onAccessTokenChangedReturnValue
    }

    //MARK: - findAccessToken

    var findAccessTokenCallsCount = 0
    var findAccessTokenCalled: Bool {
        return findAccessTokenCallsCount > 0
    }
    var findAccessTokenReturnValue: AnyPublisher<String?, Error>!
    var findAccessTokenClosure: (() -> AnyPublisher<String?, Error>)?

    func findAccessToken() -> AnyPublisher<String?, Error> {
        findAccessTokenCallsCount += 1
        return findAccessTokenClosure.map({ $0() }) ?? findAccessTokenReturnValue
    }

    //MARK: - requestAccessToken

    var requestAccessTokenWithCallsCount = 0
    var requestAccessTokenWithCalled: Bool {
        return requestAccessTokenWithCallsCount > 0
    }
    var requestAccessTokenWithReceivedCode: String?
    var requestAccessTokenWithReceivedInvocations: [String] = []
    var requestAccessTokenWithReturnValue: AnyPublisher<String, Error>!
    var requestAccessTokenWithClosure: ((String) -> AnyPublisher<String, Error>)?

    func requestAccessToken(with code: String) -> AnyPublisher<String, Error> {
        requestAccessTokenWithCallsCount += 1
        requestAccessTokenWithReceivedCode = code
        requestAccessTokenWithReceivedInvocations.append(code)
        return requestAccessTokenWithClosure.map({ $0(code) }) ?? requestAccessTokenWithReturnValue
    }

}
class GitHubOAuthIUseCaseProtocolMock: GitHubOAuthIUseCaseProtocol {

    //MARK: - onReceiveAccessToken

    var onReceiveAccessTokenCallsCount = 0
    var onReceiveAccessTokenCalled: Bool {
        return onReceiveAccessTokenCallsCount > 0
    }
    var onReceiveAccessTokenReturnValue: AnyPublisher<String, Error>!
    var onReceiveAccessTokenClosure: (() -> AnyPublisher<String, Error>)?

    func onReceiveAccessToken() -> AnyPublisher<String, Error> {
        onReceiveAccessTokenCallsCount += 1
        return onReceiveAccessTokenClosure.map({ $0() }) ?? onReceiveAccessTokenReturnValue
    }

    //MARK: - findAccessToken

    var findAccessTokenCallsCount = 0
    var findAccessTokenCalled: Bool {
        return findAccessTokenCallsCount > 0
    }
    var findAccessTokenReturnValue: AnyPublisher<String?, Error>!
    var findAccessTokenClosure: (() -> AnyPublisher<String?, Error>)?

    func findAccessToken() -> AnyPublisher<String?, Error> {
        findAccessTokenCallsCount += 1
        return findAccessTokenClosure.map({ $0() }) ?? findAccessTokenReturnValue
    }

    //MARK: - checkHasAccessToken

    var checkHasAccessTokenCallsCount = 0
    var checkHasAccessTokenCalled: Bool {
        return checkHasAccessTokenCallsCount > 0
    }
    var checkHasAccessTokenReturnValue: AnyPublisher<Bool, Error>!
    var checkHasAccessTokenClosure: (() -> AnyPublisher<Bool, Error>)?

    func checkHasAccessToken() -> AnyPublisher<Bool, Error> {
        checkHasAccessTokenCallsCount += 1
        return checkHasAccessTokenClosure.map({ $0() }) ?? checkHasAccessTokenReturnValue
    }

    //MARK: - updateCode

    var updateCodeCallsCount = 0
    var updateCodeCalled: Bool {
        return updateCodeCallsCount > 0
    }
    var updateCodeReceivedCode: String?
    var updateCodeReceivedInvocations: [String] = []
    var updateCodeReturnValue: AnyPublisher<Void, Error>!
    var updateCodeClosure: ((String) -> AnyPublisher<Void, Error>)?

    func updateCode(_ code: String) -> AnyPublisher<Void, Error> {
        updateCodeCallsCount += 1
        updateCodeReceivedCode = code
        updateCodeReceivedInvocations.append(code)
        return updateCodeClosure.map({ $0(code) }) ?? updateCodeReturnValue
    }

}
class ProfileUseCaseProtocolMock: ProfileUseCaseProtocol {

    //MARK: - getMe

    var getMeCallsCount = 0
    var getMeCalled: Bool {
        return getMeCallsCount > 0
    }
    var getMeReturnValue: AnyPublisher<MeEntity, Error>!
    var getMeClosure: (() -> AnyPublisher<MeEntity, Error>)?

    func getMe() -> AnyPublisher<MeEntity, Error> {
        getMeCallsCount += 1
        return getMeClosure.map({ $0() }) ?? getMeReturnValue
    }

    //MARK: - getMyRepoList

    var getMyRepoListCallsCount = 0
    var getMyRepoListCalled: Bool {
        return getMyRepoListCallsCount > 0
    }
    var getMyRepoListReturnValue: AnyPublisher<GitHubRepositoryList, Error>!
    var getMyRepoListClosure: (() -> AnyPublisher<GitHubRepositoryList, Error>)?

    func getMyRepoList() -> AnyPublisher<GitHubRepositoryList, Error> {
        getMyRepoListCallsCount += 1
        return getMyRepoListClosure.map({ $0() }) ?? getMyRepoListReturnValue
    }

}
class RepositoryGatewayProtocolMock: RepositoryGatewayProtocol {

    //MARK: - search

    var searchOfRepoNameCallsCount = 0
    var searchOfRepoNameCalled: Bool {
        return searchOfRepoNameCallsCount > 0
    }
    var searchOfRepoNameReceivedArguments: (owner: GitHubUserLoginID, repoName: String)?
    var searchOfRepoNameReceivedInvocations: [(owner: GitHubUserLoginID, repoName: String)] = []
    var searchOfRepoNameReturnValue: AnyPublisher<GitHubRepository, Error>!
    var searchOfRepoNameClosure: ((GitHubUserLoginID, String) -> AnyPublisher<GitHubRepository, Error>)?

    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
        searchOfRepoNameCallsCount += 1
        searchOfRepoNameReceivedArguments = (owner: owner, repoName: repoName)
        searchOfRepoNameReceivedInvocations.append((owner: owner, repoName: repoName))
        return searchOfRepoNameClosure.map({ $0(owner, repoName) }) ?? searchOfRepoNameReturnValue
    }

    //MARK: - search

    var searchWithCountCallsCount = 0
    var searchWithCountCalled: Bool {
        return searchWithCountCallsCount > 0
    }
    var searchWithCountReceivedArguments: (query: String, count: Int)?
    var searchWithCountReceivedInvocations: [(query: String, count: Int)] = []
    var searchWithCountReturnValue: AnyPublisher<GitHubRepositoryList, Error>!
    var searchWithCountClosure: ((String, Int) -> AnyPublisher<GitHubRepositoryList, Error>)?

    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        searchWithCountCallsCount += 1
        searchWithCountReceivedArguments = (query: query, count: count)
        searchWithCountReceivedInvocations.append((query: query, count: count))
        return searchWithCountClosure.map({ $0(query, count) }) ?? searchWithCountReturnValue
    }

    //MARK: - searchRepoList

    var searchRepoListOfCallsCount = 0
    var searchRepoListOfCalled: Bool {
        return searchRepoListOfCallsCount > 0
    }
    var searchRepoListOfReceivedId: GitHubUserLoginID?
    var searchRepoListOfReceivedInvocations: [GitHubUserLoginID] = []
    var searchRepoListOfReturnValue: AnyPublisher<GitHubRepositoryList, Error>!
    var searchRepoListOfClosure: ((GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error>)?

    func searchRepoList(of id: GitHubUserLoginID) -> AnyPublisher<GitHubRepositoryList, Error> {
        searchRepoListOfCallsCount += 1
        searchRepoListOfReceivedId = id
        searchRepoListOfReceivedInvocations.append(id)
        return searchRepoListOfClosure.map({ $0(id) }) ?? searchRepoListOfReturnValue
    }

}
class RepositoryUseCaseProtocolMock: RepositoryUseCaseProtocol {

    //MARK: - search

    var searchOfRepoNameCallsCount = 0
    var searchOfRepoNameCalled: Bool {
        return searchOfRepoNameCallsCount > 0
    }
    var searchOfRepoNameReceivedArguments: (owner: GitHubUserLoginID, repoName: String)?
    var searchOfRepoNameReceivedInvocations: [(owner: GitHubUserLoginID, repoName: String)] = []
    var searchOfRepoNameReturnValue: AnyPublisher<GitHubRepository, Error>!
    var searchOfRepoNameClosure: ((GitHubUserLoginID, String) -> AnyPublisher<GitHubRepository, Error>)?

    func search(of owner: GitHubUserLoginID, repoName: String) -> AnyPublisher<GitHubRepository, Error> {
        searchOfRepoNameCallsCount += 1
        searchOfRepoNameReceivedArguments = (owner: owner, repoName: repoName)
        searchOfRepoNameReceivedInvocations.append((owner: owner, repoName: repoName))
        return searchOfRepoNameClosure.map({ $0(owner, repoName) }) ?? searchOfRepoNameReturnValue
    }

    //MARK: - search

    var searchWithCountCallsCount = 0
    var searchWithCountCalled: Bool {
        return searchWithCountCallsCount > 0
    }
    var searchWithCountReceivedArguments: (query: String, count: Int)?
    var searchWithCountReceivedInvocations: [(query: String, count: Int)] = []
    var searchWithCountReturnValue: AnyPublisher<GitHubRepositoryList, Error>!
    var searchWithCountClosure: ((String, Int) -> AnyPublisher<GitHubRepositoryList, Error>)?

    func search(with query: String, count: Int) -> AnyPublisher<GitHubRepositoryList, Error> {
        searchWithCountCallsCount += 1
        searchWithCountReceivedArguments = (query: query, count: count)
        searchWithCountReceivedInvocations.append((query: query, count: count))
        return searchWithCountClosure.map({ $0(query, count) }) ?? searchWithCountReturnValue
    }

}
class UserGatewayProtocolMock: UserGatewayProtocol {

    //MARK: - fetch

    var fetchIdCallsCount = 0
    var fetchIdCalled: Bool {
        return fetchIdCallsCount > 0
    }
    var fetchIdReceivedId: GitHubUserLoginID?
    var fetchIdReceivedInvocations: [GitHubUserLoginID] = []
    var fetchIdReturnValue: AnyPublisher<GitHubUser, Error>!
    var fetchIdClosure: ((GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error>)?

    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error> {
        fetchIdCallsCount += 1
        fetchIdReceivedId = id
        fetchIdReceivedInvocations.append(id)
        return fetchIdClosure.map({ $0(id) }) ?? fetchIdReturnValue
    }

    //MARK: - fetchMe

    var fetchMeFollowerCountFolloweeCountCallsCount = 0
    var fetchMeFollowerCountFolloweeCountCalled: Bool {
        return fetchMeFollowerCountFolloweeCountCallsCount > 0
    }
    var fetchMeFollowerCountFolloweeCountReceivedArguments: (followerCount: Int, followeeCount: Int)?
    var fetchMeFollowerCountFolloweeCountReceivedInvocations: [(followerCount: Int, followeeCount: Int)] = []
    var fetchMeFollowerCountFolloweeCountReturnValue: AnyPublisher<MeEntity, Error>!
    var fetchMeFollowerCountFolloweeCountClosure: ((Int, Int) -> AnyPublisher<MeEntity, Error>)?

    func fetchMe(followerCount: Int, followeeCount: Int) -> AnyPublisher<MeEntity, Error> {
        fetchMeFollowerCountFolloweeCountCallsCount += 1
        fetchMeFollowerCountFolloweeCountReceivedArguments = (followerCount: followerCount, followeeCount: followeeCount)
        fetchMeFollowerCountFolloweeCountReceivedInvocations.append((followerCount: followerCount, followeeCount: followeeCount))
        return fetchMeFollowerCountFolloweeCountClosure.map({ $0(followerCount, followeeCount) }) ?? fetchMeFollowerCountFolloweeCountReturnValue
    }

}
