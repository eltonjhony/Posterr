//
//  DefaultUserRepository.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

final class DefaultUserRepository: UserRepository {
    
    // MARK: - Properties
    private let provider: UserProvider
    
    // MARK: - Initializers
    init(provider: UserProvider) {
        self.provider = provider
    }
    
    // MARK: - User methods
    
    func putUser(_ user: UserModel) -> AnyPublisher<UserModel, Error> {
        provider.putUser(user: user)
    }
    
    func getCurrentUser() -> AnyPublisher<UserModel, Error> {
        provider.getCurrentUser()
    }
    
    func getAllUsers() -> AnyPublisher<[UserModel], Error> {
        provider.getAllUsers()
    }
    
    func deleteAll() -> AnyPublisher<Bool, Error> {
        provider.deleteAll()
    }
    
}
