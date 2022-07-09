//
//  PosterrApp.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

@main
struct PosterrApp: App {
    
    static let user = UserModel(uuid: "4284872", username: "@eljholiveira", profilePicture: "user1", createdAt: Date())
    let posts = [
        PostModel(uuid: "48962489z29", content: "As a programmer, what is your most visited website?", createdAt: Date(), user: user, source: .post, earliestPosts: [])
    ]
    
    var body: some Scene {
        WindowGroup {
            let viewModel = TabBarView.ViewModel(tabs: [
                HomeTab(view: HomeView(posts: posts)),
                ProfileTab(view: ProfileView())
            ], selectedTab: 0)
            TabBarView(viewModel: viewModel)
        }
    }
}
