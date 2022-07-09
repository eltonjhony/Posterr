//
//  PostFetchable.swift
//  Posterr
//
//  Created by Elton Jhony on 10.07.22.
//

import Foundation

import typealias Combine.AnyPublisher

public protocol PostFetchable {
    func getPosts() -> AnyPublisher<[PostModel], Error>
}

final class PostFetchableUseCase: PostFetchable, Loggable {
    
    // MARK: - Private members

    private let postRepository: PostRepository

    // MARK: - Initialization

    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }

    // MARK: - Action Methods

    func getPosts() -> AnyPublisher<[PostModel], Error> {
        postRepository.getAllPosts()
    }

}

