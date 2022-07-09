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
            Image(systemName: "signpost.left")
            Image(systemName: "quote.bubble")
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
}
