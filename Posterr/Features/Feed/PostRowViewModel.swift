//
//  PostRowViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

extension PostRowView {
    
    final class ViewModel: ObservableObject {
        
        @Published var startQuoting: Bool = false
        
        let item: PostItem
        
        private let usecase: PostUpdatable
        
        var post: PostModel {
            item.post
        }
        
        var originalPost: PostModel? {
            item.post.originalPosts.first
        }
        
        var shouldShowMyRepostTag: Bool {
            guard let currentUser = item.currentUser else { return false }
            return currentUser.repostsId.contains(post.uuid) && !item.isMyFeed
        }
        
        var isRepostable: Bool {
            item.post.source != .repost && !shouldShowMyRepostTag
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
