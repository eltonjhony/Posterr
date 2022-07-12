//
//  FeedView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(item: PostItem) {
        viewModel = PosterrAssembler.resolve(
            PostView.ViewModel.self,
            argument: item
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            switch viewModel.post.source {
            case .post, .quote:
                content
            case .repost:
                repostContent
            }
            separatorLine
        }
        .sheet(isPresented: $viewModel.startQuoting) {
            AddPostView(
                viewModel: PosterrAssembler.resolve(
                    AddPostView.ViewModel.self,
                    argument: viewModel.post
                )
            )
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.post.user {
                HStack(alignment: .top) {
                    ProfilePicture(picture: user.profilePicture)
                    VStack(alignment: .leading) {
                        ProfileIdentification(username: user.username)
                        if case .post = viewModel.post.source {
                            Text(viewModel.post.content)
                        } else if case .quote = viewModel.post.source {
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
            if let user = viewModel.post.user {
                HStack(spacing: 2) {
                    Image(systemName: "repeat")
                    Text("Repost from \(user.username)")
                        .fontWeight(.semibold)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.contentInverted)
                .padding(.horizontal)
                if let originalPost = viewModel.post.originalPosts.first {
                    PostView(item: .init(post: originalPost, isFromFeed: false))
                }
            }
            actions
                .padding(.leading, 84)
        }
    }
    
    private var quoteContent: some View {
        VStack(alignment: .leading) {
            Text(viewModel.post.content)
            VStack(alignment: .leading, spacing: 4) {
                if let parentPost = viewModel.originalPost {
                    HStack(alignment: .top, spacing: 2) {
                        ProfilePicture(picture: viewModel.quotePostingUser?.profilePicture ?? "", size: 20)
                        ProfileIdentification(username: viewModel.quotePostingUser?.username ?? "")
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
        if viewModel.item.isFromFeed {
            HStack(spacing: 24) {
                Image(systemName: viewModel.isRepostable ? "signpost.left" : "signpost.left.fill")
                    .behaviour(.touchable(disabled: !viewModel.isRepostable, viewModel.repost))
                    .foregroundColor(.appAccent)
                Image(systemName: "quote.bubble")
                    .behaviour(.touchable() {
                        viewModel.quoteReposting()
                    }).foregroundColor(.appAccent)
                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
    
    @ViewBuilder
    private var separatorLine: some View {
        if viewModel.item.isFromFeed {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .foregroundColor(Color.appSeparator)
                .padding(.vertical, 2)
        }
    }
    
}

struct PostItem {
    let post: PostModel
    let currentUser: UserModel?
    let isFromFeed: Bool
    
    init(post: PostModel, currentUser: UserModel? = nil, isFromFeed: Bool = true) {
        self.post = post
        self.currentUser = currentUser
        self.isFromFeed = isFromFeed
    }
}
