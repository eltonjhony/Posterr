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
    
    func fetchProfileData()
}

final class ProfileInfoFetchableUseCase: ProfileInfoFetchable, Loggable {
    
    // MARK: - Private(set) members
    
    private(set) var data: CurrentValueSubject<ProfileInfoModel?, Never> = .init(nil)
    
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
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                self?.fetchMyPosts(with: user)
            }
            .store(in: &cancellables)
    }
    
    private func fetchMyPosts(with user: UserModel) {
        postRepository.getPosts(by: user.uuid)
            .sink { _ in
                
            } receiveValue: { [weak self] posts in
                self?.data.send(.init(currentUser: user, posts: posts))
            }
            .store(in: &cancellables)
    }
    
}

