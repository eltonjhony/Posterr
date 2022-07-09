//
//  UserRealmProvider.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

final class UserRealmProvider: UserProvider, Loggable {
    
    private let dbManager: DBManager
    
    init(dbManager: DBManager) {
        self.dbManager = dbManager
    }
    
    func putUser(user: UserModel) -> AnyPublisher<UserModel, Error> {
        Future { promisse in
            do {
                try self.dbManager.save(object: user.mapToPersistenceObject())
                promisse(.success(user))
            } catch let error {
                self.log(error.localizedDescription)
                promisse(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getCurrentUser() -> AnyPublisher<UserModel, Error> {
        dbManager.fetch(UserEntity.self, predicate: NSPredicate(format: "isCurrent == true"), sorted: nil)
            .tryMap { entities in
                UserModel.mapFromPersistenceObject(entities[0])
            }
            .eraseToAnyPublisher()
    }
    
    func getAllUsers() -> AnyPublisher<[UserModel], Error> {
        dbManager.fetch(UserEntity.self, predicate: nil, sorted: nil)
            .tryMap { entities in
                entities.map { UserModel.mapFromPersistenceObject($0) }
            }
            .eraseToAnyPublisher()
    }
    
    func deleteAll() -> AnyPublisher<Bool, Error> {
        Future { promisse in
            do {
                try self.dbManager.deleteAll(UserEntity.self)
                promisse(.success(true))
            } catch let error {
                self.log(error.localizedDescription)
                promisse(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
}
