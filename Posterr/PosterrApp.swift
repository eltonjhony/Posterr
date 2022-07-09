//
//  PosterrApp.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

@main
struct PosterrApp: App {
    var body: some Scene {
        WindowGroup {
            let user = UserModel(uuid: "4284872", username: "@eljholiveira", profilePicture: "", createdAt: Date())
            let posts = [
                PostModel(uuid: "48962489z29", content: "As a programmer, what is your most visited website?", createdAt: Date(), user: user, source: .post, earliestPosts: [])
            ]
            ContentView(posts: posts)
        }
    }
}
