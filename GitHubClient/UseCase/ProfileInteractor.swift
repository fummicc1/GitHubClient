//
//  ProfileInteractor.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol ProfileUseCaseOutput {
    func didFind(repoList: GitHubRepositoryList)
    func didFind(me: MeEntity)
    func didOccureError(_ error: Error)
}

protocol UserGatewayProtocol {
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error>
    func fetchMe() -> AnyPublisher<MeEntity, Error>
}

final class ProfileInteractor {
    
    internal init(
        userGateway: UserGatewayProtocol,
        repoGateway: RepositoryGatewayProtocol,
        output: ProfileUseCaseOutput,
        cancellables: Set<AnyCancellable> = Set()
    ) {
        self.userGateway = userGateway
        self.repoGateway = repoGateway
        self.output = output
        self.cancellables = cancellables
        
        me.dropFirst().sink { [weak self] me in
            guard let me = me else {
                return
            }
            self?.output.didFind(me: me)
        }
        .store(in: &self.cancellables)
        
        repoList.dropFirst().sink { [weak self] repoList in
            self?.output.didFind(repoList: repoList)
        }
        .store(in: &self.cancellables)
        
        errors.sink { [weak self] error in
            self?.output.didOccureError(error)
        }
        .store(in: &self.cancellables)
        
    }
    
    private var userGateway: UserGatewayProtocol!
    private var repoGateway: RepositoryGatewayProtocol!
    
    private var output: ProfileUseCaseOutput!
    
    private var cancellables: Set<AnyCancellable>
    
    private var me: CurrentValueSubject<MeEntity?, Never> = .init(nil)
    private var repoList: CurrentValueSubject<GitHubRepositoryList, Never> = .init(.empty)
    private let errors: PassthroughSubject<Swift.Error, Never> = .init()
}

extension ProfileInteractor: ProfileUseCaseProtocol {
    
    enum Error: Swift.Error {
        case noGetResult
        case didNotFoundMe
    }
    
    func getMe() {
        userGateway.fetchMe()
            .delegateError(to: errors)
            .sink { me in
                self.me.send(me)
            }
            .store(in: &cancellables)
    }
    
    func getMyRepoList() {
        
        guard let me = me.value else {
            output.didOccureError(Error.didNotFoundMe)
            return
        }
        
        repoGateway.searchRepoList(of: me.login)
            .delegateError(to: errors)
            .sink { repoList in
                self.repoList.send(repoList)
            }
            .store(in: &cancellables)
    }
}
