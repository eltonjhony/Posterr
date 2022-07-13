//
//  DefaultPostRepository.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

final class DefaultPostRepository: PostRepository {
    
    // MARK: - Properties
    private let provider: PostProvider
    
    // MARK: - Initializers
    init(provider: PostProvider) {
        self.provider = provider
    }
    
    // MARK: - Post methods
    
    func addPost(_ post: PostModel) -> AnyPublisher<PostModel, Error> {
        provider.addPost(post)
    }
    
    func getAllPosts() -> AnyPublisher<[PostModel], Error> {
        provider.getAllPosts()
    }
    
    func getPosts(by userId: String) -> AnyPublisher<[PostModel], Error> {
        provider.getPosts(by: userId)
    }
    
    func getMyPosts(between startDate: Date, and endDate: Date, with userId: String) -> AnyPublisher<[PostModel], Error> {
        provider.getMyPosts(between: startDate, and: endDate, with: userId)
    }
    
}
