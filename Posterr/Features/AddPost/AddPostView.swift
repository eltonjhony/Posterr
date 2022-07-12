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
        NotificationView(data: viewModel.alert, isShown: $viewModel.isAlertShown) {
            content
                .padding()
                .onAppear(perform: viewModel.onAppear)
                .onChange(of: viewModel.dismiss) { newValue in
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
    
    private var content: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewModel.submitPost()
                    } label: {
                        Text("Post")
                            .foregroundColor(.appPrimary)
                            .fontWeight(.semibold)
                    }
                    .disabled(viewModel.content.isEmpty)
                }
                
                HStack(alignment: .top) {
                    VStack {
                        if let profilePicture = viewModel.currentUser?.profilePicture {
                            ProfilePicture(picture: profilePicture)
                        }
                        CharacterCountdownView(
                            value: Double(viewModel.content.count),
                            maxCharacteres: Double(viewModel.characterLimit)
                        )
                    }
                    TextArea(
                        characterLimit: viewModel.characterLimit,
                        placeholder: viewModel.placeholderText,
                        text: $viewModel.content
                    )
                }
                
            }
            
            if let originalPost = viewModel.originalPost {
                HStack {
                    Spacer()
                    PostView(item: .init(post: originalPost, isFromFeed: false))
                }
            }
            
            Spacer()
        }
    }
    
}
