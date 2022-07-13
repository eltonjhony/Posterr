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
        NotificationView(data: viewModel.alert, isShown: $viewModel.isAlertShown) {
            content
                .style(.navBar(title: "Feed"))
                .edgesIgnoringSafeArea(.bottom)
                .onAppear(perform: viewModel.onAppear)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if let feed = viewModel.feed {
            FeedView(posts: feed.posts, currentUser: feed.currentUser)
        }
    }
    
}
