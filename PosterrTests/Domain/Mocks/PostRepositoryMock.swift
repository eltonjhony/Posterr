//
//  PostRepositoryMock.swift
//  PosterrTests
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import Combine

@testable import Posterr

final class PostRepositoryMock: PostRepository {
    
    var model: PostModel?
    var models: [PostModel] = []
    
    var error: Error?
    
    func addPost(_ post: PostModel) -> AnyPublisher<PostModel, Error> {
        Future<PostModel, Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else if let model = self.model {
                promisse(.success(model))
            }
        }.eraseToAnyPublisher()
    }

    func getAllPosts() -> AnyPublisher<[PostModel], Error> {
        Future<[PostModel], Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else {
                promisse(.success(self.models))
            }
        }.eraseToAnyPublisher()
    }

    func getPosts(by userId: String) -> AnyPublisher<[PostModel], Error> {
        Future<[PostModel], Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else {
                promisse(.success(self.models))
            }
        }.eraseToAnyPublisher()
    }

    func getMyPosts(between startDate: Date, and endDate: Date, with userId: String) -> AnyPublisher<[PostModel], Error> {
        Future<[PostModel], Error> { promisse in
            if let error = self.error {
                promisse(.failure(error))
            } else {
                promisse(.success(self.models))
            }
        }.eraseToAnyPublisher()
    }
    
}
