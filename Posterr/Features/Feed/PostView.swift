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
    
    var onRepost: ActionCompletion? = nil
    
    @State var showQuote: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = post.user {
                if case .repost = post.source {
                    Text("Repost from \(user.username)")
                }
                HStack(alignment: .top) {
                    ProfilePicture(picture: user.profilePicture)
                    VStack(alignment: .leading) {
                        ProfileIdentification(username: user.username)
                        content
                    }
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showQuote) {
            AddPostView(
                viewModel: PosterrAssembler.resolve(
                    AddPostView.ViewModel.self,
                    argument: AddPostView.SubmissionType.quote(post)
                )
            )
        }
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading) {
            Text(post.content ?? "")
            if case .quote = post.source {
                VStack {
                    if let originalPost = post.originalPosts.first {
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
            Image(systemName: "quote.bubble")
                .behaviour(.touchable({showQuote.toggle()}))
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
}
