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
        
        private let submitable: PostSubmitable
        private let fetchable: PostFetchable
        
        private var cancellables = [AnyCancellable]()
        
        init(submitable: PostSubmitable, fetchable: PostFetchable) {
            self.submitable = submitable
            self.fetchable = fetchable
        }
        
        func onAppear() {
            fetchPosts()
        }
        
        func repost(_ post: PostModel) {
            submitable.repost(post: post)
        }
        
        private func fetchPosts() {
            fetchable.getPosts()
                .sink { _ in } receiveValue: { [weak self] posts in
                    self?.posts = posts
                }.store(in: &cancellables)
        }
        
    }
    
}
