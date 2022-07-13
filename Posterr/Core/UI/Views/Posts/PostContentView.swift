//
//  PostContentView.swift
//  Posterr
//
//  Created by Elton Jhony on 13.07.22.
//

import Foundation
import SwiftUI

struct PostContentView: View {
    let post: PostModel
    let canRepost: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                ProfilePicture(picture: post.user?.profilePicture)
                VStack(alignment: .leading) {
                    ProfileIdentification(username: post.user?.username)
                    if [.post, .repost].contains(post.source) {
                        Text(post.content)
                    } else if case .quote = post.source {
                        QuoteContentView(post: post, originalPost: post.originalPosts.first)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
}
