//
//  PostRealmProvider.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

final class PostRealmProvider: PostProvider, Loggable {
    
    private let dbManager: DBManager
    
    private let sortingByCreatedDate = Sorted(key: "createdAt", ascending: false)
    
    init(dbManager: DBManager) {
        self.dbManager = dbManager
    }
    
    func addPost(_ post: PostModel) -> AnyPublisher<PostModel, Error> {
        Future { promisse in
            do {
                try self.dbManager.save(object: post.mapToPersistenceObject())
                promisse(.success(post))
            } catch let error {
                self.log(error.localizedDescription)
                promisse(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getAllPosts() -> AnyPublisher<[PostModel], Error> {
        dbManager.fetch(PostEntity.self, predicate: nil, sorted: sortingByCreatedDate)
            .tryMap { entities in
                entities.map { PostModel.mapFromPersistenceObject($0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getPosts(by userId: String) -> AnyPublisher<[PostModel], Error> {
        let predicate = NSPredicate(format: "user.uuid == %@", userId)
        return dbManager.fetch(
            PostEntity.self,
            predicate: predicate,
            sorted: sortingByCreatedDate)
            .tryMap { entities in
                entities.map { PostModel.mapFromPersistenceObject($0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getMyPosts(between startDate: Date, and endDate: Date, with userId: String) -> AnyPublisher<[PostModel], Error> {
        let predicate = NSPredicate(
            format: "user.uuid == %@ AND createdAt >= %@ AND createdAt <= %@",
            userId,
            startDate as CVarArg,
            endDate as CVarArg)
        return dbManager.fetch(
            PostEntity.self,
            predicate: predicate,
            sorted: sortingByCreatedDate)
            .tryMap { entities in
                entities.map { PostModel.mapFromPersistenceObject($0) }
            }
            .eraseToAnyPublisher()
    }
    
}
