//
//  PostView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct PostView: View {
    let post: PostModel
    
    let onRepost: ActionCompletion?
    let onQuote: ActionCompletion?
    
    init(post: PostModel, onRepost: ActionCompletion? = nil, onQuote: ActionCompletion? = nil) {
        self.post = post
        self.onRepost = onRepost
        self.onQuote = onQuote
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if case .repost = post.source {
                Text("Repost from \(post.user.username)")
            }
            HStack(alignment: .top) {
                ProfilePicture(picture: post.user.profilePicture)
                VStack(alignment: .leading) {
                    ProfileIdentification(username: post.user.username)
                    content
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading) {
            Text(post.content ?? "")
            if case .quote = post.source {
                VStack {
                    if let originalPost = post.earliestPosts.first {
                        PostView(post: originalPost)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .cornerRadius(8)
            }
            actions
        }
    }
    
    private var actions: some View {
        HStack(spacing: 24) {
            if let onRepost = onRepost {
                Image(systemName: "signpost.left")
                    .behaviour(.touchable(onRepost))
            }
            if let onQuote = onQuote {
                Image(systemName: "quote.bubble")
                    .behaviour(.touchable(onQuote))
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
}
