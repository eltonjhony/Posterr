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
            .flatMap {
                self.submitPost(for: $0, with: .init(content: content))
            }
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
        userRepository.getCurrentUser()
            .flatMap {
                self.submitPost(for: $0, with: .init(source: .repost, originalPost: post))
            }
            .sink {
                if case let .failure(error) = $0 {
                    //TODO: Handle error
                    debugPrint(error)
                }
            } receiveValue: { [weak self] model in
                self?.didPost.send(model)
            }.store(in: &cancellables)
    }
    
    func quote(of post: PostModel, with content: String) {
        userRepository.getCurrentUser()
            .flatMap {
                self.submitPost(for: $0, with: .init(content: content, source: .quote, originalPost: post))
            }
            .sink {
                if case let .failure(error) = $0 {
                    //TODO: Handle error
                    debugPrint(error)
                }
            } receiveValue: { [weak self] model in
                self?.didPost.send(model)
            }.store(in: &cancellables)
    }
    
    private func submitPost(for user: UserModel, with request: SubmitRequest) -> AnyPublisher<PostModel, Error> {
        let post = PostModel(
            uuid: UUID().uuidString,
            content: request.content,
            createdAt: Date(),
            user: user,
            source: request.source,
            originalPosts: request.originalPost != nil ? [request.originalPost!] : []
        )
        return postRepository.addPost(post)
    }
    
    private struct SubmitRequest {
        let content: String?
        let source: SourceType
        let originalPost: PostModel?
        
        init(content: String? = nil, source: SourceType = .post, originalPost: PostModel? = nil) {
            self.content = content
            self.source = source
            self.originalPost = originalPost
        }
    }

}
