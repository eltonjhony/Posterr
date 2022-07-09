//
//  HomeViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        @Published var posts = [
            PostModel(uuid: "48962489z29", content: "As a programmer, what is your most visited website?", createdAt: Date(), user: UserModel(uuid: "4284872", username: "@eljholiveira", profilePicture: "user1", createdAt: Date()), source: .post, earliestPosts: [])
        ]
        
    }
    
}
