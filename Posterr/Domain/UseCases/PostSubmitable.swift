//
//  PostSubmitable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

public protocol PostSubmitable {
    var didPost: PassthroughSubject<PostModel, Never> { get }
    
    func post(with content: String)
    func repost(post: PostModel)
    func quote(of post: PostModel, with content: String)
}

final class PostSubmitableUseCase: PostSubmitable, Loggable {
    
    // MARK: - Private(set) members
    
    private(set) var didPost: PassthroughSubject<PostModel, Never> = .init()
    
    // MARK: - Private members

    private let userRepository: UserRepository
    private let postRepository: PostRepository
    
    private var cancellables = [AnyCancellable]()

    // MARK: - Initialization

    init(userRepository: UserRepository, postRepository: PostRepository) {
        self.userRepository = userRepository
        self.postRepository = postRepository
    }

    // MARK: - Action Methods
    
    func post(with content: String) {
        userRepository.getCurrentUser()
            .flatMap { self.submitPost(for: $0, with: content) }
            .sink {
                if case let .failure(error) = $0 {
                    //TODO: Handle error
                    debugPrint(error)
                }
            } receiveValue: { [weak self] model in
                self?.didPost.send(model)
            }.store(in: &cancellables)
    }
    
    func repost(post: PostModel) {
        
    }
    
    func quote(of post: PostModel, with content: String) {
        
    }
    
    private func submitPost(for user: UserModel, with content: String, source: SourceType = .post) -> AnyPublisher<PostModel, Error> {
        let post = PostModel(
            uuid: UUID().uuidString,
            content: content,
            createdAt: Date(),
            user: user,
            source: .post,
            earliestPosts: []
        )
        return postRepository.addPost(post)
    }

}
