//
//  FeedView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct PostRowView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(item: PostItem) {
        viewModel = PosterrAssembler.resolve(
            PostRowView.ViewModel.self,
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
            AddPostView(type: .quote(viewModel.post))
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: .zero) {
            if viewModel.shouldShowMyRepostTag {
                RepostIdentificationView(username: viewModel.post.user?.username)
                    .padding(.vertical, 4)
            }
            PostContentView(
                post: viewModel.post,
                canRepost: viewModel.isRepostable)
            actions
        }
    }
    
    private var repostContent: some View {
        VStack(alignment: .leading, spacing: .zero) {
            RepostIdentificationView(
                username: viewModel.post.user?.username,
                isFromCurrentUser: viewModel.item.isMyFeed
            )
            .padding(.vertical, 4)
            if let originalPost = viewModel.post.originalPosts.first {
                PostContentView(post: originalPost, canRepost: false)
            }
            actions
        }
    }
    
    private var actions: some View {
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
        .padding(.leading, 84)
    }
    
    @ViewBuilder
    private var separatorLine: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: 1)
            .foregroundColor(Color.appSeparator)
            .padding(.vertical, 2)
    }
    
}

struct PostItem {
    let post: PostModel
    let currentUser: UserModel?
    let isMyFeed: Bool
    
    init(post: PostModel, currentUser: UserModel? = nil, isMyFeed: Bool = false) {
        self.post = post
        self.currentUser = currentUser
        self.isMyFeed = isMyFeed
    }
}
