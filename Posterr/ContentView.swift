//
//  ContentView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct ContentView: View {
    let posts: [PostModel]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                header
                content
            }
            actionLayer
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var header: some View {
        HStack {
            Text("Posterr Feed")
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                timeline
            }
        }
    }
    
    private var actionLayer: some View {
        VStack {
            Spacer()
            HStack(spacing: .zero) {
                Spacer()
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50, alignment: .center)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                    )
            }
            .padding()
        }
    }
    
    private var timeline: some View {
        ForEach(posts, id: \.uuid) { post in
            PostView(post: post)
                .frame(width: UIScreen.main.bounds.width, alignment: .center)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModel(uuid: "4284872", username: "@eljholiveira", profilePicture: "user1", createdAt: Date())
        let posts = [
            PostModel(uuid: "48962489z29", content: "As a programmer, what is your most visited website?", createdAt: Date(), user: user, source: .repost, earliestPosts: [.init(uuid: "3637813637", content: "Quote from post", createdAt: Date(), user: user, source: .post, earliestPosts: [])])
        ]
        return ContentView(posts: posts)
    }
}
