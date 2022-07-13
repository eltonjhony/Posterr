//
//  PostUpdatable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

public enum PostableError: Error {
    case dailyLimitExceeded
    case contentExceeded
}

public enum PostLimit: Int {
    case content = 777
    case dailyPosts = 5
}

public protocol PostUpdatable {
    var didUpdate: PassthroughSubject<Void, Never> { get }
    var didError: PassthroughSubject<Error, Never> { get }
    
    func post(with content: String)
    func repost(post: PostModel)
    func quote(of post: PostModel, with content: String)
}

final class PostUpdatableUseCase: PostUpdatable, Loggable {
    
    // MARK: - Private(set) members
    
    private(set) var didUpdate: PassthroughSubject<Void, Never> = .init()
    private(set) var didError: PassthroughSubject<Error, Never> = .init()
    
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
        let request: SubmitRequest = .init(content: content)
        userRepository.getCurrentUser()
            .flatMap { user in
                self.validateSubmission(with: user, and: request.content)
                    .flatMap { self.submitPost(with: request, user).eraseToAnyPublisher() }
                    .eraseToAnyPublisher()
            }
            .sink(didUpdate, didError)
            .store(in: &cancellables)
    }
    
    func repost(post: PostModel) {
        let request: SubmitRequest = .init(content: post.content, source: .repost, originalPost: post)
        userRepository.getCurrentUser()
            .flatMap { user in
                self.validateSubmission(with: user, and: request.content)
                    .flatMap { self.submitPost(with: request, user).eraseToAnyPublisher() }
                    .eraseToAnyPublisher()
            }
            .sink(didUpdate, didError)
            .store(in: &cancellables)
    }
    
    func quote(of post: PostModel, with content: String) {
        let request: SubmitRequest = .init(content: content, source: .quote, originalPost: post)
        userRepository.getCurrentUser()
            .flatMap { user in
                self.validateSubmission(with: user, and: request.content)
                    .flatMap { self.submitPost(with: request, user).eraseToAnyPublisher() }
                    .eraseToAnyPublisher()
            }
            .sink(didUpdate, didError)
            .store(in: &cancellables)
    }
    
    private func validateSubmission(with user: UserModel, and content: String) -> AnyPublisher<Void, Error> {
        guard content.count < PostLimit.content.rawValue else {
            return Fail(error: PostableError.contentExceeded).eraseToAnyPublisher()
        }
        return postRepository.getMyPosts(between: Date().startOfDay, and: Date().endOfDay, with: user.uuid)
            .tryMap { myDailyPosts in
                guard myDailyPosts.count < PostLimit.dailyPosts.rawValue else { throw PostableError.dailyLimitExceeded }
            }.eraseToAnyPublisher()
    }
    
    private func submitPost(with request: SubmitRequest, _ user: UserModel) -> AnyPublisher<PostModel, Error> {
        postRepository.addPost(request.makePost(with: user))
            .flatMap { post in
                self.updateReferences(to: user, with: post)
                    .map { _ in post }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func updateReferences(to user: UserModel, with post: PostModel) -> AnyPublisher<UserModel, Error> {
        guard let postId = post.originalPosts.first?.uuid else {
            return userRepository.putUser(user.changing {
                $0.postsCount += 1
            })
        }
        guard post.source == .repost else {
            return userRepository.putUser(user.changing {
                $0.quotePostingCount += 1
            })
        }
        return userRepository.putUser(user.changing {
            $0.repostsId.append(postId)
            $0.repostsCount += 1
        })
    }
    
    private struct SubmitRequest {
        let content: String
        let source: SourceType
        let originalPost: PostModel?
        
        init(content: String, source: SourceType = .post, originalPost: PostModel? = nil) {
            self.content = content
            self.source = source
            self.originalPost = originalPost
        }
        
        func makePost(with user: UserModel) -> PostModel {
            PostModel(
                uuid: UUID().uuidString,
                content: content,
                createdAt: Date(),
                user: user,
                source: source,
                originalPosts: originalPost != nil ? [originalPost!] : []
            )
        }
    }

}

private extension Publisher where Output == PostModel {
    func sink(_ didUpdate: PassthroughSubject<Void, Never>, _ didError: PassthroughSubject<Error, Never>) -> AnyCancellable {
        sink {
            if case let .failure(error) = $0 {
                didError.send(error)
            }
        } receiveValue: { _ in
            didUpdate.send()
        }
    }
}
