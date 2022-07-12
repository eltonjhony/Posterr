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
            .style(.navBar(title: "Feed"))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: viewModel.onAppear)
    }
    
    @ViewBuilder
    private var content: some View {
        FeedView(posts: viewModel.posts) { post in
            viewModel.repost(post)
        }
    }
    
}
