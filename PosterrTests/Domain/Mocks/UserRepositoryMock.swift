//
//  UserRepositoryMock.swift
//  PosterrTests
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import Combine

@testable import Posterr

final class UserRepositoryMock: UserRepository {
    
    var model: UserModel?
    var models: [UserModel] = []
    
    var puttedUser: UserModel?
    
    var error: Error?
    
    func putUser(_ user: UserModel) -> AnyPublisher<UserModel, Error> {
        puttedUser = user
        return Future<UserModel, Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else if let model = self.model {
                promisse(.success(model))
            }
        }.eraseToAnyPublisher()
    }
    
    func getCurrentUser() -> AnyPublisher<UserModel, Error> {
        Future<UserModel, Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else if let model = self.model {
                promisse(.success(model))
            }
        }.eraseToAnyPublisher()
    }
    
    func getAllUsers() -> AnyPublisher<[UserModel], Error> {
        Future<[UserModel], Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else {
                promisse(.success(self.models))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteAll() -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else {
                promisse(.success(true))
            }
        }.eraseToAnyPublisher()
    }
    
}
