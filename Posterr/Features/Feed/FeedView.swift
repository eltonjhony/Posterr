//
//  FeedView.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

struct FeedView: View {
    let posts: [PostModel]
    let currentUser: UserModel?
    
    var isMyFeed: Bool = false

    @ViewBuilder
    var body: some View {
        if posts.isEmpty {
            EmptyStateView()
        } else {
            timeline
        }
    }
    
    private var timeline: some View {
        ScrollView {
            ForEach(posts, id: \.uuid) { post in
                PostRowView(item: .init(
                    post: post,
                    currentUser: currentUser,
                    isMyFeed: isMyFeed)
                )
            }
        }
    }
}
