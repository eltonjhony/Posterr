//
//  UserRegistrable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

public protocol UserRegistrable {
    func register()
}

final class UserRegistrableUseCase: UserRegistrable, Loggable {
    
    // MARK: - Private members

    private let userRepository: UserRepository
    
    private var cancellables = [AnyCancellable]()

    // MARK: - Initialization

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
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
