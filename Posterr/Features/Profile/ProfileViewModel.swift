//
//  ProfileViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension ProfileView {
    
    class ViewModel: ObservableObject {
        
        @Published var posts: [PostModel] = []
        
        private let submitable: PostSubmitable
        private let fetchable: PostFetchable
        
        private var cancellables = [AnyCancellable]()
        
        init(submitable: PostSubmitable, fetchable: PostFetchable) {
            self.submitable = submitable
            self.fetchable = fetchable
            
            registerForSubmitableUpdates()
        }
        
        func onAppear() {
            fetchMyPosts()
        }
        
        func repost(_ post: PostModel) {
            submitable.repost(post: post)
        }
        
        private func fetchMyPosts() {
            fetchable.getPosts()
                .sink { _ in } receiveValue: { [weak self] posts in
                    self?.posts = posts
                }.store(in: &cancellables)
        }
        
        private func registerForSubmitableUpdates() {
            submitable.didPost.sink { [weak self] _ in
                self?.fetchMyPosts()
            }.store(in: &cancellables)
        }
    }
    
}
