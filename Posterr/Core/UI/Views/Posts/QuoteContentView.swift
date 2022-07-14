//
//  QuoteContentView.swift
//  Posterr
//
//  Created by Elton Jhony on 13.07.22.
//

import Foundation
import SwiftUI

struct QuoteContentView: View {
    let post: PostModel
    let originalPost: PostModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.content)
            VStack(alignment: .leading, spacing: 4) {
                if let parentPost = originalPost {
                    HStack(alignment: .top, spacing: 2) {
                        ProfilePictureView(picture: post.quotingUser?.profilePicture ?? "", size: 20)
                        ProfileIdentificationView(username: post.quotingUser?.username ?? "")
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
    
}

private extension PostModel {
    var quotingUser: UserModel? {
        guard let originalPost = originalPosts.first else { return nil }
        guard case .repost = originalPost.source else { return originalPost.user }
        return originalPost.originalPosts.first?.user ?? originalPost.user
    }
}
