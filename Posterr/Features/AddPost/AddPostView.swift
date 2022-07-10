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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            VStack {
                HStack {
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
                    TextArea(placeholder: viewModel.placeholderText, text: $viewModel.content)
                }
                
            }
            
            if let originalPost = viewModel.originalPost {
                HStack {
                    Spacer()
                    PostView(post: originalPost, isFromFeed: false)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear(perform: viewModel.onAppear)
        .onChange(of: viewModel.dismiss) { newValue in
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    enum SubmissionType: Equatable {
        case post
        case repost(PostModel)
        case quote(PostModel)
    }
}
