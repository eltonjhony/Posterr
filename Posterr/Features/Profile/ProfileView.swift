//
//  ProfileView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            profileThumbnail
            content
        }
        .style(.navBar(title: "Profile"))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: viewModel.onAppear)
    }
    
    private var profileThumbnail: some View {
        VStack {
            Spacer()
                .frame(width: UIScreen.main.bounds.width, height: 50)
                .background(Color.appPrimary)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .overlay(profilePicture, alignment: .bottom)
    }
    
    @ViewBuilder
    private var profilePicture: some View {
        if let user = viewModel.data?.currentUser {
            ProfilePicture(picture: user.profilePicture, size: 90)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if let data = viewModel.data {
            VStack {
                ProfileIdentification(username: data.currentUser.username)
                Text("Joined \(data.joinerDate)")
                countPosts.padding(.vertical)
                ScrollView {
                    ForEach(data.posts, id: \.uuid) { post in
                        PostView(post: post, isFromCurrentUser: true) {
                            viewModel.repost(post)
                        }
                    }
                }.padding(.vertical)
                Spacer()
            }
        }
    }
    
    private var countPosts: some View {
        HStack(spacing: 16) {
            if let data = viewModel.data {
                HStack(spacing: 2) {
                    Text("posts:")
                    Text("\(data.postsCount)")
                        .fontWeight(.semibold)
                }
                
                HStack(spacing: 2) {
                    Text("reposts:")
                    Text("\(data.repostCount)")
                        .fontWeight(.semibold)
                }
                
                HStack(spacing: 2) {
                    Text("quote-posts:")
                    Text("\(data.quoteCount)")
                        .fontWeight(.semibold)
                }
            }
        }
    }
    
}
