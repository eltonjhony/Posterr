//
//  NavBarModifier.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct NavBarModifier: ViewModifier {
    let title: String
    
    @State var showAddPost: Bool = false
    
    @EnvironmentObject var sceneDelegate: SceneDelegate
    
    func body(content: Content) -> some View {
        VStack(spacing: .zero) {
            header
                .padding(.top, sceneDelegate.window?.statusBarHeight ?? 0)
            content
                .sheet(isPresented: $showAddPost) {
                    AddPostView(type: .post)
                }
        }
        .edgesIgnoringSafeArea(.top)
    }

    private var header: some View {
        VStack {
            HStack(spacing: 16) {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                    .fixedSize(horizontal: false, vertical: true)
                    

                Spacer()

                Button {
                    showAddPost.toggle()
                } label: {
                    Text("Add Post")
                        .foregroundColor(.appPrimary)
                        .fontWeight(.semibold)
                }

            }
            .padding(.top, 8)
        }
        .padding(.leading, 24)
        .padding(.trailing, 16)
        .frame(height: .headerHeight, alignment: .center)
    }

}

extension CGFloat {
    static let headerHeight: CGFloat = 84
}
