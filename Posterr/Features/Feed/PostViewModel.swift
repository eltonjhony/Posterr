//
//  PostViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

extension PostView {
    
    final class ViewModel: ObservableObject {
        
        @Published var startQuoting: Bool = false
        
        let item: PostItem
        
        private let usecase: PostUpdatable
        
        var isRepostable: Bool {
            item.post.source != .repost
        }
        
        var post: PostModel {
            item.post
        }
        
        var currentUser: UserModel? {
            item.currentUser
        }
        
        var originalPost: PostModel? {
            item.post.originalPosts.first
        }
        
        var quotePostingUser: UserModel? {
            guard let originalPost = originalPost else { return nil }
            guard case .repost = originalPost.source else { return originalPost.user }
            return originalPost.originalPosts.first?.user ?? originalPost.user
        }
        
        init(item: PostItem, usecase: PostUpdatable) {
            self.item = item
            self.usecase = usecase
        }
        
        func quoteReposting() {
            startQuoting.toggle()
        }
        
        func repost() {
            usecase.repost(post: item.post)
        }
        
    }
    
}
