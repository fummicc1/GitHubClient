//
//  ProfileViewModelMock.swift
//  GitHubClient
//
//  Created by Fumiya Tanaka on 2021/08/18.
//

import Foundation
import Combine

protocol ProfileViewModelProtocol {
    func findMe()
    func findMyRepoList()
}

class ProfileViewModel: ObservableObject, ProfileViewModelProtocol {
    
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var myRepoList: [GitHubRepositoryViewData] = []
    @Published var me: MeViewData?
    @Published var error: ErrorMessageViewData?
    
    private var useCase: ProfileUseCaseProtocol!
    
    func inject(useCase: ProfileUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func findMyRepoList() {        
        useCase.getMyRepoList()
            .sink { completion in
                if case let .failure(error) = completion {
                    self.didOccureError(error)
                }
            } receiveValue: { repoList in
                self.didFind(repoList: repoList)
            }
            .store(in: &cancellable)

    }
    
    func findMe() {
        useCase.getMe()
            .sink { completion in
                if case let .failure(error) = completion {
                    self.didOccureError(error)
                }
            } receiveValue: { me in
                self.didFind(me: me)
            }
            .store(in: &cancellable)

    }
    
}

extension ProfileViewModel {
    
    func didFind(repoList: GitHubRepositoryList) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let repoViewList = repoList.repositories.map({ repo in
            GitHubRepositoryViewData(
                id: repo.id.id,
                userName: repo.owner.login.id,
                avatarURL: repo.owner.avatarUrl,
                name: repo.name,
                description: repo.description,
                isPrivate: repo.isPrivate,
                createDate: dateFormatter.string(from: repo.createdAt),
                url: repo.url,
                languages: repo.languages.map({ lang in
                    GitHubRepositoryViewData.Language(name: lang.name, color: lang.colorCode)
                }),
                mostUsedLangauge: repo.languages.map({ lang in
                    GitHubRepositoryViewData.Language(name: lang.name, color: lang.colorCode)
                }).first
            )
        })
        
        self.myRepoList = repoViewList
    }
    
    func didFind(me: MeEntity) {
        let meViewData = MeViewData(
            login: me.login.id,
            avatarUrl: me.avatarUrl,
            bio: me.bio,
            followers: me.followers.map({ user in
                GitHubUserViewData(
                    loginID: user.login.id,
                    avatarURL: user.avatarUrl
                )
            }),
            followersCount: me.followersCount,
            followees: me.followees.map({ user in
                GitHubUserViewData(
                    loginID: user.login.id,
                    avatarURL: user.avatarUrl
                )
            }),
            followeesCount: me.followersCount
        )
        self.me = meViewData
    }
    
    func didOccureError(_ error: Swift.Error) {
        let errorMessage = ErrorMessageViewData(
            error: error,
            message: "エラー: \(error.localizedDescription)"
        )
        self.error = errorMessage
    }
}

extension ProfileViewModel {
    enum Error: Swift.Error {
        case didNotFoundMe
    }
}
