//
//  FeedView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct PostView: View {
    let post: PostModel
    
    var isFromFeed: Bool = true
    
    var onRepost: ActionCompletion? = nil
    @State var startQuoting: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            switch post.source {
            case .post, .quote:
                content
            case .repost:
                repostContent
            }
            separatorLine
        }
        .sheet(isPresented: $startQuoting) {
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
                        actions
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
                        .fontWeight(.semibold)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.contentInverted)
                .padding(.horizontal)
                if let originalPost = post.originalPosts.first {
                    PostView(post: originalPost, isFromFeed: false)
                }
            }
            actions
                .padding(.leading, 84)
        }
    }
    
    private var quoteContent: some View {
        VStack(alignment: .leading) {
            Text(post.content)
            VStack(alignment: .leading, spacing: 4) {
                if let parentPost = post.originalPosts.first {
                    HStack(alignment: .top, spacing: 2) {
                        ProfilePicture(picture: parentPost.quotePostUser?.profilePicture ?? "", size: 20)
                        ProfileIdentification(username: parentPost.quotePostUser?.username ?? "")
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
                if let onRepost = onRepost {
                    Image(systemName: post.isRepostable ? "signpost.left" : "signpost.left.fill")
                        .behaviour(.touchable(disabled: !post.isRepostable, onRepost))
                        .foregroundColor(.appAccent)
                }
                Image(systemName: "quote.bubble")
                    .behaviour(.touchable() {
                        startQuoting.toggle()
                    }).foregroundColor(.appAccent)
                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
    
    @ViewBuilder
    private var separatorLine: some View {
        if isFromFeed {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .foregroundColor(Color.appSeparator)
                .padding(.vertical, 2)
        }
    }
    
}
