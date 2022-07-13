//
//  FeedFetchable.swift
//  Posterr
//
//  Created by Elton Jhony on 13.07.22.
//

import Foundation
import Combine

public protocol FeedFetchable {
    var data: CurrentValueSubject<FeedModel?, Never> { get }
    var didError: PassthroughSubject<Error, Never> { get }
    
    func fetchMyFeed()
}

final class FeedFetchableUseCase: FeedFetchable, Loggable {
    
    // MARK: - Private(set) members
    
    private(set) var data: CurrentValueSubject<FeedModel?, Never> = .init(nil)
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
    
    func fetchMyFeed() {
        userRepository.getCurrentUser()
            .flatMap { user in
                self.postRepository.getAllPosts()
                    .map { posts in
                        (user, self.dropMyReposts(posts, userId: user.uuid))
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] in
                if case let .failure(error) = $0 {
                    self?.didError.send(error)
                }
            } receiveValue: { [weak self] (user, posts) in
                self?.data.send(.init(currentUser: user, posts: posts))
            }
            .store(in: &cancellables)
    }
    
    private func dropMyReposts(_ posts: [PostModel], userId: String?) -> [PostModel] {
        posts.dropping { $0.source == .repost && $0.user?.uuid == userId }
    }
    
}

private extension Array where Element == PostModel {
    func dropping(condition: (Element) -> Bool) -> [Element] {
        var elements = self
        elements.removeAll { condition($0) }
        return elements
    }
}
