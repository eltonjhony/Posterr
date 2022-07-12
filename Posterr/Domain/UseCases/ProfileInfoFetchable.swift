//
//  ProfileInfoFetchable.swift
//  Posterr
//
//  Created by Elton Jhony on 10.07.22.
//

import Foundation
import Combine

public protocol ProfileInfoFetchable {
    var data: CurrentValueSubject<ProfileInfoModel?, Never> { get }
    var didError: PassthroughSubject<Error, Never> { get }
    
    func fetchProfileData()
}

final class ProfileInfoFetchableUseCase: ProfileInfoFetchable, Loggable {
    
    // MARK: - Private(set) members
    
    private(set) var data: CurrentValueSubject<ProfileInfoModel?, Never> = .init(nil)
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
    
    func fetchProfileData() {
        userRepository.getCurrentUser()
            .flatMap { user in
                self.postRepository.getPosts(by: user.uuid)
                    .map { posts in (user, posts) }
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
    
}
