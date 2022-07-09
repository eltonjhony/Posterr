//
//  AddPostViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

extension AddPostView {
    
    class ViewModel: ObservableObject {
        
        @Published var currentUser: UserModel? = UserModel(uuid: "4284872", username: "@eljholiveira", profilePicture: "user1", createdAt: Date())
        @Published var content: String = ""
        
    }
    
}
