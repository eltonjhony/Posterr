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
                .background(Color.blue.opacity(0.4))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .overlay(profilePicture, alignment: .bottom)
    }
    
    private var profilePicture: some View {
        VStack {
            if let user = viewModel.data?.currentUser {
                Image(user.profilePicture)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
        }
        .frame(width: 90, height: 90, alignment: .center)
        .cornerRadius(80)
        .overlay(
            RoundedRectangle(cornerRadius: 80)
                .stroke(Color.white, lineWidth: 4)
        )
    }
    
    @ViewBuilder
    private var content: some View {
        if let data = viewModel.data {
            VStack {
                Text(data.currentUser.username)
                Text("Joined \(data.joinerDate)")
                countPosts.padding(.vertical)
                ScrollView {
                    ForEach(data.posts, id: \.uuid) { post in
                        PostView(post: post) {
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
                    Text("\(data.postsCount)")
                        .fontWeight(.semibold)
                    Text("post")
                }
                
                HStack(spacing: 2) {
                    Text("\(data.repostCount)")
                        .fontWeight(.semibold)
                    Text("repost")
                }
                
                HStack(spacing: 2) {
                    Text("\(data.quoteCount)")
                        .fontWeight(.semibold)
                    Text("quote-posts")
                }
            }
        }
    }
    
}
