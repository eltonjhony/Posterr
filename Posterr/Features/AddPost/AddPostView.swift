//
//  AddPostView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct AddPostView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Button {
                        viewModel.submitPost()
                    } label: {
                        Text("Post")
                    }
                }
                
                HStack(alignment: .top) {
                    if let profilePicture = viewModel.currentUser?.profilePicture {
                        ProfilePicture(picture: profilePicture)
                    }
                    
                    TextArea(placeholder: "What's happening", text: $viewModel.content)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: viewModel.onAppear)
    }
}
