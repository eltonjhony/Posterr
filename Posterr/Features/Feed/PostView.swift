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
    
    var isFromFeed: Bool = true
    
    var onRepost: ActionCompletion? = nil
    @State var showQuote: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                switch post.source {
                case .post, .quote:
                    content
                case .repost:
                    repostContent
                }
                actions
            }
        }
        .padding(.vertical, 4)
        .sheet(isPresented: $showQuote) {
            AddPostView(
                viewModel: PosterrAssembler.resolve(
                    AddPostView.ViewModel.self,
                    argument: AddPostView.SubmissionType.quote(post)
                )
            )
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            if let user = post.user {
                HStack(alignment: .top) {
                    ProfilePicture(picture: user.profilePicture)
                    VStack(alignment: .leading) {
                        ProfileIdentification(username: user.username)
                        if case .post = post.source {
                            Text(post.content)
                        } else if case .quote = post.source {
                            quoteContent
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var repostContent: some View {
        VStack(alignment: .leading, spacing: .zero) {
            if let user = post.user {
                HStack(spacing: 2) {
                    Image(systemName: "repeat")
                    Text("Repost from \(user.username)")
                    Spacer()
                }
                .padding(.horizontal)
                if let originalPost = post.originalPosts.first {
                    PostView(post: originalPost, isFromFeed: false)
                }
            }
        }
    }
    
    private var quoteContent: some View {
        VStack(alignment: .leading) {
            Text(post.content)
            VStack(alignment: .leading, spacing: 4) {
                if let parentPost = post.originalPosts.first {
                    HStack(alignment: .top, spacing: 2) {
                        ProfilePicture(picture: parentPost.user?.profilePicture ?? "", size: 20)
                        ProfileIdentification(username: parentPost.user?.username ?? "")
                        Spacer()
                    }
                    Text(parentPost.content)
                    if let originalPost = parentPost.originalPosts.first {
                        Text("posterr.com/\(originalPost.user?.username ?? "")/\(originalPost.uuid)")
                            .lineLimit(1)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .cornerRadius(8)
        }
    }
    
    @ViewBuilder
    private var actions: some View {
        if isFromFeed {
            HStack(spacing: 24) {
                Spacer()
                if let onRepost = onRepost {
                    Image(systemName: "signpost.left")
                        .behaviour(.touchable(onRepost))
                }
                Image(systemName: "quote.bubble")
                    .behaviour(.touchable({showQuote.toggle()}))
                
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
        }
    }
    
}
