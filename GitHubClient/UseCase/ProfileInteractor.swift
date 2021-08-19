//
//  ProfileInteractor.swift
//  GitHubClient (iOS)
//
//  Created by Fumiya Tanaka on 2021/07/25.
//

import Foundation
import Combine

protocol ProfileUseCaseOutput {
    func didFindUser(_ user: GitHubUser)
    func didFindMe(_ me: MeEntity)
    func didOccureError(_ error: Error)
}

protocol UserGatewayProtocol {
    func fetch(id: GitHubUserLoginID) -> AnyPublisher<GitHubUser, Error>
    func fetchMe() -> AnyPublisher<MeEntity, Error>
}

final class ProfileInteractor {
    
    internal init(
        userGateway: UserGatewayProtocol?,
        output: ProfileUseCaseOutput?,
        cancellables: Set<AnyCancellable> = Set()
    ) {
        self.userGateway = userGateway
        self.output = output
        self.cancellables = cancellables
    }
    
    private var userGateway: UserGatewayProtocol!
    
    private var output: ProfileUseCaseOutput!
    
    private var cancellables: Set<AnyCancellable>
}

extension ProfileInteractor: ProfileUseCaseProtocol {
    
    enum Error: Swift.Error {
        case noGetResult
    }
    
    func getMe() {
        var me: MeEntity?
        userGateway.fetchMe()
            .sink { [weak self] completion in
                guard let self = self else {
                    return
                }
                switch completion {
                case .finished:
                    if let me = me {
                        self.output.didFindMe(me)
                    } else {
                        self.output.didOccureError(Error.noGetResult)
                    }
                    
                case .failure(let error):
                    self.output.didOccureError(error)
                }
            } receiveValue: { response in
                me = response
            }
            .store(in: &cancellables)

    }
    
    func get(with id: GitHubUserLoginID) {
        var user: GitHubUser?
        userGateway.fetch(id: id)
            .sink { [weak self] completion in
                guard let self = self else {
                    return
                }
                switch completion {
                case .finished:
                    if let user = user {
                        self.output.didFindUser(user)
                    } else {
                        self.output.didOccureError(Error.noGetResult)
                    }
                    
                case .failure(let error):
                    self.output.didOccureError(error)
                }
            } receiveValue: { response in
                user = response
            }
            .store(in: &cancellables)
    }
}
