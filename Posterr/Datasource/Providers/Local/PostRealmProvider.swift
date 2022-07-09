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
    
}

