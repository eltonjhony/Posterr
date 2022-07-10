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
        
        private let repository: PostRepository
        private let usecase: PostSubmitable
        
        private var cancellables = [AnyCancellable]()
        
        init(usecase: PostSubmitable, repository: PostRepository) {
            self.usecase = usecase
            self.repository = repository
            
            registerForSubmitableUpdates()
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
        
        private func registerForSubmitableUpdates() {
            usecase.didPost.sink { [weak self] _ in
                self?.fetchPosts()
            }.store(in: &cancellables)
        }
        
    }
    
}
