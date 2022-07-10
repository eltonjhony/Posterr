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
            Image("user1")
                .resizable()
                .scaledToFill()
                .clipped()
                
        }
        .frame(width: 90, height: 90, alignment: .center)
        .cornerRadius(80)
        .overlay(
            RoundedRectangle(cornerRadius: 80)
                .stroke(Color.white, lineWidth: 4)
        )
    }
    
    private var content: some View {
        VStack {
            Text("ELTON OLIVEIRA")
            Text("Joined July 2022")
            countingPosts
            timeline.padding(.vertical)
            Spacer()
        }
    }
    
    private var countingPosts: some View {
        HStack(spacing: 16) {
            
            HStack(spacing: 2) {
                Text("3")
                Text("post")
            }
            
            HStack(spacing: 2) {
                Text("4")
                Text("repost")
            }
            
            HStack(spacing: 2) {
                Text("1")
                Text("quote")
            }
            
        }
    }
    
    private var timeline: some View {
        ScrollView {
            ForEach(viewModel.posts, id: \.uuid) { post in
                PostView(post: post) {
                    viewModel.repost(post)
                }
            }
        }
    }
    
}
