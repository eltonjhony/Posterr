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
    
    // MARK: - User methods
    
    func addPost(_ post: PostModel) -> AnyPublisher<PostModel, Error> {
        provider.addPost(post)
    }
    
}
