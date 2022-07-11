//
//  HomeViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        @Published var posts: [PostModel] = []
        @Published var currentUser: UserModel?
        
        private let repository: PostRepository
        private let usecase: PostUpdatable
        private let userRegistrable: UserRegistrable
        
        private var cancellables = [AnyCancellable]()
        
        init(usecase: PostUpdatable, repository: PostRepository, userRegistrable: UserRegistrable) {
            self.usecase = usecase
            self.repository = repository
            self.userRegistrable = userRegistrable
            
            registerForUpdates()
        }
        
        func onAppear() {
            fetchPosts()
        }
        
        func repost(_ post: PostModel) {
            usecase.repost(post: post)
        }
        
        private func fetchPosts() {
            repository.getAllPosts()
                .sink { _ in
                    //TODO: Handle errors
                } receiveValue: { [weak self] posts in
                    self?.posts = posts
                }.store(in: &cancellables)
        }
        
        private func registerForUpdates() {
            usecase.didUpdate.sink { [weak self] _ in
                self?.fetchPosts()
            }.store(in: &cancellables)
            
            userRegistrable.didChangeUser
                .assign(to: \.currentUser, on: self)
                .store(in: &cancellables)
        }
        
    }
    
}
