//
//  HomeView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        content
            .style(.navBar(title: "Posterr Feed"))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: viewModel.onAppear)
    }
    
    private var content: some View {
        ScrollView {
            ForEach(viewModel.posts, id: \.uuid) { post in
                PostView(post: post) {
                    viewModel.repost(post)
                }
            }
        }
    }
    
}
