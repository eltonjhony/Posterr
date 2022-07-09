//
//  UserRepository.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

public protocol UserRepository {
    func putUser(_ user: UserModel) -> AnyPublisher<UserModel, Error>
    func getCurrentUser() -> AnyPublisher<UserModel, Error>
    func getAllUsers() -> AnyPublisher<[UserModel], Error>
    func deleteAll() -> AnyPublisher<Bool, Error>
}
