//
//  UserRegistrable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

public protocol UserRegistrable {
    var didChangeUser: PassthroughSubject<UserModel, Never> { get }
    
    func register()
    func changeCurrentUser(with user: UserModel)
}

final class UserRegistrableUseCase: UserRegistrable, Loggable {
    
    // MARK: - Private(set) members
    
    private(set) var didChangeUser: PassthroughSubject<UserModel, Never> = .init()
    
    // MARK: - Private members

    private let userRepository: UserRepository
    private let postUpdatable: PostUpdatable
    
    private var cancellables = [AnyCancellable]()

    // MARK: - Initialization

    init(userRepository: UserRepository, postUpdatable: PostUpdatable) {
        self.userRepository = userRepository
        self.postUpdatable = postUpdatable
    }

    // MARK: - Action Methods

    func register() {
        userRepository.getAllUsers()
            .sink { _ in } receiveValue: { [weak self] users in
                if users.isEmpty {
                    self?.createFakeUsers()
                }
            }.store(in: &cancellables)
    }
    
    func changeCurrentUser(with user: UserModel) {
        userRepository.getCurrentUser()
            .flatMap { currentUser in
                return self.userRepository.putUser(currentUser.changing { $0.isCurrent = false })
            }
            .flatMap { _ in
                return self.userRepository.putUser(user.changing { $0.isCurrent = true })
            }
            .sink { _ in } receiveValue: { [weak self] currentUser in
                self?.didChangeUser.send(currentUser)
                self?.postUpdatable.didUpdate.send()
            }.store(in: &cancellables)
    }
    
    private func createFakeUsers() {
        let fakeUsers = [
            UserModel(uuid: UUID().uuidString, username: "@maike143", profilePicture: "user1", createdAt: Date(), isCurrent: true),
            UserModel(uuid: UUID().uuidString, username: "@nickolas873", profilePicture: "user2", createdAt: Date(), isCurrent: false),
            UserModel(uuid: UUID().uuidString, username: "@eljholiveira123", profilePicture: "user3", createdAt: Date(), isCurrent: false),
            UserModel(uuid: UUID().uuidString, username: "@newjoiner44", profilePicture: "user4", createdAt: Date(), isCurrent: false),
            UserModel(uuid: UUID().uuidString, username: "@kbob675", profilePicture: "user5", createdAt: Date(), isCurrent: false)
        ]
        fakeUsers.forEach { user in
            _ = userRepository.putUser(user)
        }
    }

}

private extension UserModel {
    func changing(change: (inout UserModel) -> Void) -> UserModel {
        var user = self
        change(&user)
        return user
    }
}
