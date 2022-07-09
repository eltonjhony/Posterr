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
    
    func body(content: Content) -> some View {
        VStack(spacing: .zero) {
            header
                .padding(.top, .statusBarHeight)
            content
                .sheet(isPresented: $showAddPost) {
                    PosterrAssembler.resolve(AddPostView.self)
                }
        }
        .edgesIgnoringSafeArea(.top)
    }

    private var header: some View {
        VStack {
            HStack(spacing: 16) {
                Text(title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()

                Button {
                    showAddPost.toggle()
                } label: {
                    Text("Add Post")
                }

            }
            .padding(.top, 8)
        }
        .padding(.leading, 24)
        .padding(.trailing, 16)
        .frame(height: .headerHeight, alignment: .center)
    }

}

private extension CGFloat {
    static let headerHeight: CGFloat = 84
    static var statusBarHeight = CGFloat(UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
}
