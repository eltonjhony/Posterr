//
//  FeedView.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

struct FeedView: View {
    let feed: FeedModel

    @ViewBuilder
    var body: some View {
        if feed.posts.isEmpty {
            EmptyStateView()
        } else {
            timeline
        }
    }
    
    private var timeline: some View {
        ScrollView {
            ForEach(feed.posts, id: \.uuid) { post in
                PostRowView(item: .init(
                    post: post,
                    currentUser: feed.currentUser,
                    isMyFeed: feed.isMyFeed)
                )
            }
        }
    }
}
