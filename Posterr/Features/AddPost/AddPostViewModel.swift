//
//  AddPostViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

extension AddPostView {
    
    class ViewModel: ObservableObject {
        
        @Published var currentUser: UserModel? = PosterrApp.user
        @Published var content: String = ""
        
    }
    
}
